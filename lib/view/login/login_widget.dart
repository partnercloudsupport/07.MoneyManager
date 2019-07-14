import 'dart:async';
import 'dart:ui';

import 'package:base_bloc/base_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_manager/utils/navigation.dart';
import 'package:money_manager/utils/prefs.dart';
import 'package:money_manager/utils/snack_bar.dart';
import 'package:money_manager/utils/string_utils.dart';
import 'package:money_manager/utils/style.dart';
import 'package:money_manager/utils/utils.dart';
import 'package:money_manager/utils/widgets/animation_button.dart';
import 'package:money_manager/utils/widgets/confirm_dialog.dart';
import 'package:money_manager/utils/widgets/rounded_textfield.dart';
import 'package:money_manager/view/home/home_widget.dart';
import 'package:money_manager/view/login/forgot_password/forgot_password_popup_widget.dart';
import 'package:money_manager/view/login/register/register_widget_export.dart';
import 'package:money_manager/view/mm_localizations_delegate.dart';

import './login_widget_export.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends BaseBlocState<LoginWidget>
  with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  BuildContext _context;

  AnimationController _loginButtonController;

  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  bool isConfirmingCreateAccount = false;

  @override
  void initState() {
    super.initState();

    _loginButtonController = new AnimationController(
      duration: new Duration(milliseconds: 1000), vsync: this);

    // Todo: show saved email
    _emailController.addListener(() =>
      dispatch(LoginEventEmail(_emailController.text.trim())));
    _passwordController.addListener(() =>
      dispatch(LoginEventPassword(_passwordController.text.trim())));
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
    BaseBlocBuilder<LoginState>(bloc, _buildBody);

  @override
  BaseBloc createBloc() => LoginBloc();

  Widget _buildBody(BuildContext context, LoginState state) {
    _emailController.value = TextEditingValue(text: state.email,
      selection: TextSelection.collapsed(offset: state.email.length));
    _passwordController.value = TextEditingValue(text: state.password,
      selection: TextSelection.collapsed(offset: state.password.length));

    _updateStatusBar();

    if (state.error != null) {
      // Show error
      showError(
        state.error.toString().replaceFirst('Exception: ', 'Error: '),
        _context);
      _playAnimation(false);
      dispatch(InitialEvent());
    } else if (state.session != null) {
      // Go to Home screen
      saveSession(state.session);
      onWidgetDidBuild(() {
        navigateToScreen(
          HomeWidget(session: state.session,),
          context,
          isReplace: true);
      });
    }

    if(state.message != null) {
      showMessage(state.message, _context);
      dispatch(InitialEvent());
    }

    if((state.googleUser != null || state.facebookUser != null || state.twitterUser != null)
      && !isConfirmingCreateAccount) {
      onWidgetDidBuild(() {
        isConfirmingCreateAccount = true;
        _confirmCreateAccount(state.googleUser ?? state.facebookUser ?? state.twitterUser);
      });
    } else if(state.googleUser == null && state.facebookUser == null && state.twitterUser == null) {
      isConfirmingCreateAccount = false;
    }

    final _emailInputWidget = Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Money Manager',
          style: TextStyle(
            fontFamily: 'IndieFlower',
            fontWeight: FontWeight.bold,
            fontSize: 45,
            color: Colors.white
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16,),
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(horizontal: 20),
          height: 260,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white.withOpacity(0.85),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16,),
              // Todo Email
              RoundedTextField(
                maxLine: 1,
                hintText: "Email",
                style: TextStyle(
                  fontSize: 18.0, color: Color(0xFF333333)),
                focusNode: _emailFocusNode,
                prefixIcon: state.email.isEmpty ||
                  isValidEmail(state.email)
                  ? Icon(
                  Icons.account_circle,
                  color: Color(0xFF919191),
                )
                  : Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                nextFocus: _passwordFocusNode,
              ),
              SizedBox(height: 10,),
              // Todo Password
              RoundedTextField(
                maxLine: 1,
                hintText: "Password",
                style: TextStyle(
                  fontSize: 18.0, color: Color(0xFF333333)),
                focusNode: _passwordFocusNode,
                prefixIcon: _passwordController.text.isEmpty ||
                  isValidPassword(state.password)
                  ? Icon(
                  Icons.vpn_key,
                  color: Colors.grey,
                )
                  : Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                obscureText: state.isObscureText,
                suffixIcon: GestureDetector(
                  onTap: () =>
                    dispatch(
                      LoginEventObscureText(!state.isObscureText)),
                  child: Icon(
                    state.isObscureText ? Icons.visibility : Icons
                      .visibility_off,
                    color: Colors.grey,
                    semanticLabel:
                    state.isObscureText
                      ? 'show password'
                      : 'hide password',
                  ),
                ),
                textInputAction: TextInputAction.done,
                done: () {},
                keyboardType: TextInputType.text,
                controller: _passwordController,
              ),
              SizedBox(height: 16,),
              AnimationButton(
                text: "Sign in",
                fontSize: 20,
                isEnable: isValidEmail(state.email) &&
                  isValidPassword(state.password),
                controller: _loginButtonController.view,
                onTap: () => _startLogin(),
              ),
              Expanded(child: Container()),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Forgot your password ?',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.blue[800], size: 15,)
                  ],
                ),
                onTap: () => _startForgotPassWidget(),
              ),
            ],
          ),
        ),
      ],
    );
    
    final _snsWidget = Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () => dispatch(LoginEventLoginGoogle()),
                  child: SvgPicture.asset(
                    'images/ic_google_round.svg',
                  ),
                ),
                Text('Google', style: TextStyle(color: Colors.white),),
              ],
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () => dispatch(LoginEventLoginFacebook()),
                  child: SvgPicture.asset(
                    'images/ic_facebook_round.svg',
                  ),
                ),
                Text(
                  'Facebook', style: TextStyle(color: Colors.white),),
              ],
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () => dispatch(LoginEventLoginTwitter()),
                  child: SvgPicture.asset(
                    'images/ic_twitter_round.svg',
                  ),
                ),
                Text('Twitter', style: TextStyle(color: Colors.white),),
              ],
            ),
          ],
        ),
        SizedBox(height: 16,),
        InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Register new account ?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  decoration: TextDecoration.underline,),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 15,)
            ],
          ),
          onTap: () => _registerSheet(state),
        ),
        SizedBox(height: 16,),
      ],
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: Builder(builder: (BuildContext context) {
        _context = context;
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: MyColors.mainColor,
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                _emailInputWidget,
                _snsWidget,
              ],
            ),
          ),
        );
      })
    );
  }

  Future<void> _updateStatusBar() async {
    try {
      await FlutterStatusbarManager.setColor(MyColors.mainColor);
      await FlutterStatusbarManager.setStyle(StatusBarStyle.LIGHT_CONTENT);
      await FlutterStatusbarManager.setNavigationBarColor(MyColors.mainColor);
      await FlutterStatusbarManager.setNavigationBarStyle(
        NavigationBarStyle.LIGHT);
    } catch (e) {
      print('_updateStatusBar ----> $e');
    }
  }

  _confirmCreateAccount(dynamic user) async {
    final result = await Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) =>
        ConfirmDialog(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(MoneyManagerLocalizations.of(context).newAccountConfirm, style: TextStyle(
                  color: Color(0xff424242), fontSize: 16,
                  fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20,),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: (user is FirebaseUser) ? 'Email : '
                          : (user is FacebookUserDto) ? 'Facebook : '
                          : 'Twitter : ',
                        style: TextStyle(
                          color: Color(0xff424242),
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      TextSpan(
                        text: (user is FirebaseUser) ? user.email
                          : (user is FacebookUserDto) ? user.name
                          : (user is TwitterUserDto) ? user.name : '',
                        style: TextStyle(
                          color: Color(0xff424242),
                          fontSize: 16,
                        )
                      ),
                    ]
                  )
                )
              ],
            ),
          ),
        ))
    );

    if(result == 'OK') {
      dispatch(LoginEventLoginCreateAccount());
    }
  }

  void _registerSheet(LoginState state) {
    _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      return RegisterWidget();
    }, backgroundColor: Colors.transparent);
  }

  _startForgotPassWidget() async {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) =>
        ForgotPasswordPopupWidget(onClose: () {})));
  }

  _startLogin() {
    _playAnimation(true);
    dispatch(LoginEventLogin());
  }

  Future<Null> _playAnimation(bool direction) async {
    try {
      if (direction) {
        await _loginButtonController.forward();
      } else {
        await _loginButtonController.reverse();
      }
    } on TickerCanceled {}
  }

}


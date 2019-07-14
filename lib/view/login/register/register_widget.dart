import 'package:base_bloc/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/utils/snack_bar.dart';
import 'package:money_manager/utils/string_utils.dart';
import 'package:money_manager/utils/style.dart';
import 'package:money_manager/utils/utils.dart';
import 'package:money_manager/utils/widgets/animation_button.dart';
import 'package:money_manager/utils/widgets/rounded_textfield.dart';
import 'package:money_manager/view/home/home_widget_export.dart';

import './register_widget_export.dart';

class RegisterWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends BaseBlocState<RegisterWidget>
  with TickerProviderStateMixin {

  BuildContext _context;

  AnimationController _loginButtonController;

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _loginButtonController = new AnimationController(
      duration: new Duration(milliseconds: 1000), vsync: this);

    _usernameController.addListener(() =>
      dispatch(RegisterEventUserName(_usernameController.text.trim())));
    _emailController.addListener(() =>
      dispatch(RegisterEventEmail(_emailController.text.trim())));
    _passwordController.addListener(() =>
      dispatch(RegisterEventPassword(_passwordController.text.trim())));
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
    BaseBlocBuilder<RegisterState>(bloc, _buildBody);

  @override
  BaseBloc createBloc() => RegisterBloc();

  Widget _buildBody(BuildContext context, RegisterState state) {
    _usernameController.value = TextEditingValue(text: state.username,
    selection: TextSelection.collapsed(offset: state.username.length));
    _emailController.value = TextEditingValue(text: state.email,
      selection: TextSelection.collapsed(offset: state.email.length));
    _passwordController.value = TextEditingValue(text: state.password,
      selection: TextSelection.collapsed(offset: state.password.length));

    if (state.error != null) {
      // Show error
      showError(state.error, _context);
      _playAnimation(false);
      dispatch(InitialEvent());
    }

    if(state.message != null) {
      showMessage(state.message, _context);
      dispatch(InitialEvent());
      _playAnimation(false);
    }

    if (state.session != null) {
      // Go to Home screen
      onWidgetDidBuild(() {
        Navigator.of(context).pushReplacement(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) =>
            HomeWidget(session: state.session,)));
      });
    }
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.transparent,
      body: Builder(builder: (BuildContext context) {
        _context = context;
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(color: MyColors.mainColor),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0)),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: MediaQuery.of(context).size.height / 1.1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _usernameController.clear();
                                  _emailController.clear();
                                  _passwordController.clear();
                                },
                                icon: Icon(
                                  Icons.highlight_off,
                                  size: 30.0,
                                  color: Theme
                                    .of(context)
                                    .primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                        height: 50,
                        width: 50,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 140,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    child: Align(
                                      child: Container(
                                        width: 130,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme
                                            .of(context)
                                            .primaryColor),
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  Center(
                                    child: Icon(Icons.group_add, color: Colors.white, size: 90,),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16,),
                            RoundedTextField(
                              maxLine: 1,
                              hintText: "Display Name",
                              style: TextStyle(
                                fontSize: 18.0, color: Color(0xFF333333)),
                              prefixIcon: Icon(
                                Icons.account_circle,
                                color: Color(0xFF919191),
                              ),
                              controller: _usernameController,
                              nextFocus: _emailFocusNode,
                            ),
                            SizedBox(height: 16,),
                            RoundedTextField(
                              maxLine: 1,
                              hintText: "Email",
                              style: TextStyle(
                                fontSize: 18.0, color: Color(0xFF333333)),
                              focusNode: _emailFocusNode,
                              prefixIcon: state.email.isEmpty ||
                                isValidEmail(state.email)
                                ? Icon(
                                Icons.email,
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
                            SizedBox(height: 16,),
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
                                    RegisterEventObscureText(!state.isObscureText)),
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
                              text: "Register",
                              fontSize: 20,
                              isEnable: isValidEmail(state.email) &&
                                isValidPassword(state.password) && state.username.isNotEmpty,
                              controller: _loginButtonController.view,
                              onTap: () => _startRegister(),
                            ),
                            SizedBox(height: 20,),
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      })
    );

  }

  _startRegister() {
    _playAnimation(true);
    dispatch(RegisterEventRegister());
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


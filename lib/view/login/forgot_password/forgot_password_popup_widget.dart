import 'package:base_bloc/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/utils/snack_bar.dart';
import 'package:money_manager/utils/string_utils.dart';
import 'package:money_manager/utils/style.dart';
import 'package:money_manager/utils/widgets/animation_button.dart';
import 'package:money_manager/utils/widgets/rounded_textfield.dart';
import 'package:money_manager/view/mm_localizations_delegate.dart';
import 'bloc.dart';

class ForgotPasswordPopupWidget extends StatefulWidget{
  final VoidCallback onClose;

  const ForgotPasswordPopupWidget({Key key, this.onClose}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ForgotPasswordPopupWidgetState();
}

class ForgotPasswordPopupWidgetState extends BaseBlocState<ForgotPasswordPopupWidget>
  with TickerProviderStateMixin {

  BuildContext _context;
  // Animation
  AnimationController controller;
  Animation<double> opacityAnimation;
  Animation<double> scaleAnimation;

  final emailController = TextEditingController();
  AnimationController _sendButtonController;

  @override
  void initState() {
    super.initState();

    controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    opacityAnimation = Tween<double>(begin: 0.0, end: 0.4).animate(
      CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    scaleAnimation =
      CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();

    emailController.addListener(
        () => dispatch(ForgotPasswordEventEmail(emailController.text.toString())));

    _sendButtonController = AnimationController(
      duration: Duration(milliseconds: 1000), vsync: this);
  }

  @override
  Widget build(BuildContext context) =>
    BaseBlocBuilder<ForgotPasswordPopupState>(bloc, _buildBody);

  @override
  BaseBloc createBloc() => ForgotPasswordPopupBloc();

  Widget _buildBody(BuildContext context, ForgotPasswordPopupState state) {
    if (state.error != null) {
      // Show error
      showError(
        state.error.toString().replaceFirst('Exception: ', 'Error: '), _context);
      _playAnimation(false);
      dispatch(InitialEvent());

    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Builder(builder: (BuildContext context) {
        _context = context;
        return Material(
          color: Colors.black.withOpacity(opacityAnimation.value),
          child: Center(
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.all(20),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(MoneyManagerLocalizations.of(context).resetPasswordTitle,
                      style: Theme.of(context).textTheme.title.copyWith(color: MyColors.mainColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30,),
                    RoundedTextField(
                      textInputAction: TextInputAction.done,
                      done: _startRequest,
                      hintText: MoneyManagerLocalizations.of(context).resetPasswordEmail,
                      controller: emailController,
                      maxLine: 1,
                      error: state.error,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 20,),
                    AnimationButton(
                      text: MoneyManagerLocalizations.of(context).resetPassword,
                      height: 45,
                      isEnable: isValidEmail(state.email),
                      controller: _sendButtonController.view,
                      onTap: () => dispatch(ForgotPasswordEventRequest()),
                    ),
                    SizedBox(height: 5,),
                    ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 45),
                      child: OutlineButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(MoneyManagerLocalizations.of(context).no,
                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
                        borderSide: BorderSide(color: Colors.black12),
                        shape: StadiumBorder(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  _startRequest(ForgotPasswordPopupState state) {
    _playAnimation(true);
    dispatch(ForgotPasswordEventRequest());
  }

  Future<Null> _playAnimation(bool direction) async {
    try {
      if (direction) {
        await _sendButtonController.forward();
      } else {
        await _sendButtonController.reverse();
      }
    } on TickerCanceled {}
  }

}


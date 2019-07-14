import 'package:flutter/material.dart';
import 'package:money_manager/utils/widgets/gradient_button.dart';

/// Created by Huan.Huynh on 2019-07-05.
///
/// Copyright © 2019 teqnological. All rights reserved.
class AnimationButton extends StatelessWidget {
  AnimationButton(
    {Key key,
      this.startColor = const Color(0xFF1D303D),
      this.endColor = const Color(0xFF1D303D),
      this.disableColor = Colors.grey,
      this.controller,
      this.text = "",
      this.isEnable = true,
      @required this.onTap,
      this.height = 50,
      this.fontSize,
    })
    : _animation = new Tween(
    begin: 350.0,
    end: 50.0,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: new Interval(
        0.0,
        0.150,
      ),
    ),
  ),
      super(key: key) {
    assert(onTap != null);
  }

  final Color startColor;
  final Color endColor;
  final Color disableColor;
  final AnimationController controller;
  final Animation _animation;
  final String text;
  final bool isEnable;
  final GestureTapCallback onTap;
  final double height;
  final double fontSize;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return _animation.value <= 300
      ? _normalButton()
      : InkWell(
      onTap: isEnable ? onTap : null,
      child: GradientButton(
        startColor: startColor,
        endColor: endColor,
        disableColor: disableColor,
        text: text,
        fontSize: fontSize,
        isEnable: isEnable,
        height: height,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }

  Widget _normalButton() {
    return InkWell(
      onTap: isEnable ? onTap : null,
      child: Center(
        child: Container(
          padding: EdgeInsets.only(left: 5,right: 5),
          width: _animation.value == 40 ? _animation.value : _animation.value,
          height: height,
          alignment: FractionalOffset.center,
          decoration: _getBackground(),
          child: _animation.value > 300.0
            ? Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
              fontFamily: "Roboto-Light"),
          )
            : _animation.value < 300.0
            ? CircularProgressIndicator(
            value: null,
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
            : null),
      ),
    );
  }

  ShapeDecoration _getBackground() {
    return ShapeDecoration(
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(50),
      ),
      // Box decoration takes a gradient
      gradient: LinearGradient(
        // Where the linear gradient begins and ends
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        // Add one stop for each color. Stops should increase from 0 to 1
        stops: [0.0, 1.0],
        colors: [
          // Colors are easy thanks to Flutter's Colors class.
          isEnable ? startColor : disableColor,
          isEnable ? endColor : disableColor,
        ],
      ),
    );
  }
}
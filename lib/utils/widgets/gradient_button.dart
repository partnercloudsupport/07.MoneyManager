import 'package:flutter/material.dart';

/// Created by Huan.Huynh on 2019-07-05.
///
/// Copyright © 2019 teqnological. All rights reserved.
class GradientButton extends StatelessWidget {
  final Color startColor;
  final Color endColor;
  final Color disableColor;
  final String text;
  final bool isEnable;
  final double height;
  final double fontSize;

  GradientButton(
    {
      this.startColor = const Color(0xFF49839D),
      this.endColor = const Color(0xFF49839D),
      this.text,
      this.disableColor,
      this.isEnable,
      this.height = 50,
      this.fontSize = 16,
    }
    );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      alignment: FractionalOffset.center,
      decoration: ShapeDecoration(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.all(Radius.circular(height / 2)),
        ),
        // Box decoration takes a gradient
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
      ),
      child: Text(
        text,
        style: TextStyle(inherit: false,
          fontSize: fontSize, color: Colors.white, fontFamily: "Roboto-Bold"),
      ),
    );
  }
}
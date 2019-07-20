import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../style.dart';

/// Created by Huan.Huynh on 2019-04-23.
///
/// Copyright © 2019 teqnological. All rights reserved.
class BorderInputTextField extends StatelessWidget {
  final FocusNode focusNode;
  final Widget icon;
  final String hintText;
  final Color hintTextColor;
  final Color textColor;
  final TextEditingController controller;

  final TextInputType keyboardType;

  final Widget suffixIcon;
  final bool obscureText;

  final TextInputAction textInputAction;

  final FocusNode nextFocus;

  final String error;

  final int maxLines;
  final int minLines;

  final List<TextInputFormatter> inputFormatter;

  final Function done;

  final double fontSize;
  final FontWeight fontWeight;

  final TextCapitalization textCapitalization;

  final EdgeInsetsGeometry contentPadding;

  BorderInputTextField({this.focusNode,
    this.icon,
    this.suffixIcon,
    this.hintText = "",
    this.hintTextColor = Colors.black45,
    this.textColor = defaultTextColor,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.sentences,
    this.nextFocus,
    this.maxLines,
    this.minLines = 1,
    this.inputFormatter,
    this.fontSize = 18,
    this.fontWeight = FontWeight.normal,
    this.contentPadding = const EdgeInsets.all(15),
    this.error,
    this.done});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: TextFormField(
        textAlign: TextAlign.start,
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatter,
        decoration: InputDecoration(
          contentPadding: contentPadding,
          icon: icon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 0.5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1),
          ),
          labelText: hintText,
          labelStyle: TextStyle(fontFamily: 'Roboto-ThinItalic')
        ),
        minLines: minLines,
        maxLines: maxLines,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: fontSize, color: textColor, fontWeight: fontWeight),
        onFieldSubmitted: (v) {
          if (textInputAction == TextInputAction.next) {
            FocusScope.of(context).requestFocus(nextFocus);
          } else if (textInputAction == TextInputAction.done) {
            done();
          }
        },
      ),
    );
  }
}

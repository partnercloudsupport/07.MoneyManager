import 'package:flutter/material.dart';

///Created by Huan.Huynh on 2019-07-05.
///
///Copyright © 2019 teqnological. All rights reserved.
class RoundedTextField extends StatelessWidget {
  final FocusNode focusNode;
  final Widget prefixIcon;
  final String hintText;
  final Color fillColor;
  final Color textColor;
  final TextEditingController controller;

  final TextInputType keyboardType;

  final Widget suffixIcon;
  final bool obscureText;

  final TextInputAction textInputAction;

  final FocusNode nextFocus;

  final String error;

  final int maxLine;

  final Function done;

  final TextStyle style;

  RoundedTextField(
    {this.focusNode,
      this.prefixIcon,
      this.suffixIcon,
      this.hintText = "",
      this.fillColor,
      this.textColor = Colors.black,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.textInputAction = TextInputAction.next,
      this.nextFocus,
      this.maxLine,
      this.style = const TextStyle(fontSize: 22.0, color: Color(0xFF333333)),
      this.error,
      this.done});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextFormField(
        focusNode: focusNode,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          filled: fillColor != null,
          fillColor: fillColor,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
        maxLines: maxLine,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: style,
        onSaved: (String value) {},
        onFieldSubmitted: (v) {
          focusNode.unfocus();
          if(textInputAction == TextInputAction.next) {
            FocusScope.of(context).requestFocus(nextFocus);
          } else if(textInputAction == TextInputAction.done) {
            done();
          }
        },
        controller: controller,
      ),
      Container(
        child: error == null
          ? Container()
          : Container(
          margin: EdgeInsets.only(top: 8),
          width: double.infinity,
          child: Text(error,style: TextStyle(color: Theme.of(context).errorColor),),
        ),
      ),
    ]);
  }
}
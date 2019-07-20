import 'package:flutter/material.dart';
import 'package:cool_ui/cool_ui.dart';
import 'package:money_manager/utils/string_utils.dart';

/// Created by Huan.Huynh on 2019-07-16.
///
/// Copyright © 2019 teqnological. All rights reserved.

class CalculateNumberKeyboard extends StatelessWidget{
  static const CKTextInputType inputType = const CKTextInputType(name:'CKNumberKeyboard');
  static double getHeight(BuildContext ctx){
    MediaQueryData mediaQuery = MediaQuery.of(ctx);
    return mediaQuery.size.width / 3 / 2 * 4;
  }
  final KeyboardController controller ;
  const CalculateNumberKeyboard({this.controller});

  static register(){
    CoolKeyboard.addKeyboard(CalculateNumberKeyboard.inputType,KeyboardConfig(builder: (context,controller){
      return CalculateNumberKeyboard(controller: controller);
    },getHeight: CalculateNumberKeyboard.getHeight));
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Material(
      child: DefaultTextStyle(style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 23.0), child: Container(
        height:getHeight(context),
        width: mediaQuery.size.width,
        decoration: BoxDecoration(
          color: Color(0xffafafaf),
        ),
        child: GridView.count(
          childAspectRatio: 1.9/1,
          mainAxisSpacing:0.5,
          crossAxisSpacing:0.5,
          padding: EdgeInsets.all(0.0),
          crossAxisCount: 4,
          children: <Widget>[
            Container(
              color: Color(0xFFE2E6EB),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Center(child: Center(child: Text('C'),),),
                onTap: () {
                  controller.clear();
                },
              ),
            ),
            Container(
              color: Color(0xFFE2E6EB),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Center(child: Center(child: Text('÷'),),),
                onTap: (){
                  controller.addText(' ÷ ');
                },
              ),
            ),
            Container(
              color: Color(0xFFE2E6EB),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Center(child: Center(child: Text('×'),),),
                onTap: (){
                  controller.addText(' × ');
                },
              ),
            ),
            Container(
              color: Color(0xFFE2E6EB),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Center(child: Center(child: Text('⌫'),),),
                onTap: () {
                  if(controller.text.endsWith(' ')) {
                    controller.deleteOne();
                    controller.deleteOne();
                    controller.deleteOne();
                  } else if(controller.text.length > 1) {
                    controller.deleteOne();
                  } else {
                    controller.value = TextEditingValue(text: '0',
                      selection: TextSelection.collapsed(offset: 1));
                  }
                },
              ),
            ),
            buildButton('1'),
            buildButton('2'),
            buildButton('3'),
            Container(
              color: Color(0xFFE2E6EB),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Center(child: Center(child: Text('-'),),),
                onTap: (){
                  controller.addText(' - ');
                },
              ),
            ),
            buildButton('4'),
            buildButton('5'),
            buildButton('6'),
            Container(
              color: Color(0xFFE2E6EB),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Center(child: Center(child: Text('+'),),),
                onTap: (){
                  controller.addText(' + ');
                },
              ),
            ),
            buildButton('7'),
            buildButton('8'),
            buildButton('9'),
            Container(
              color: Color(0xFFE2E6EB),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Center(child: Center(child: Text('±'),),),
                onTap: (){

                  int value = inputtedValue(controller.text);

                  String _shown = toMoney(value * -1);
                  controller.value = TextEditingValue(text: _shown,
                    selection: TextSelection.collapsed(offset: _shown.length));
                },
              ),
            ),
            Container(
              color: Color(0xFFE2E6EB),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Center(child: Icon(Icons.expand_more),),
                onTap: (){

                  int value = inputtedValue(controller.text);

                  String _shown = toMoney(value);
                  controller.value = TextEditingValue(text: _shown,
                    selection: TextSelection.collapsed(offset: _shown.length));
                  controller.doneAction();
                },
              ),
            ),
            buildButton('0'),
            buildButton('000'),
            Container(
              color: Color(0xFFE2E6EB),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Center(child: Center(child: Text('='),),),
                onTap: (){

                  int value = inputtedValue(controller.text);

                  String _shown = toMoney(value);
                  controller.value = TextEditingValue(text: _shown,
                    selection: TextSelection.collapsed(offset: _shown.length));
                },
              ),
            ),
          ]),
      )),
    );
  }

  Widget buildButton(String title,{String value}){
    if(value == null){
      value = title;
    }
    return Container(
      color: Colors.white,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Center(child: Text(title),),
        onTap: (){
          controller.addText(value);
        },
      ),
    );
  }
}
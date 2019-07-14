import 'package:flutter/material.dart';
import 'package:money_manager/utils/exception.dart';
import 'package:money_manager/utils/navigation.dart';
import 'package:money_manager/utils/utils.dart';
import 'package:money_manager/view/login/login_widget_export.dart';

/// Created by Huan.Huynh on 2019-07-05.
///
/// Copyright © 2019 teqnological. All rights reserved.

Future<Null> showError(dynamic error, context) async {
  onWidgetDidBuild((){
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: ListTile(
        leading: Icon(Icons.error, color: Colors.white,),
        title: Text('${error.toString()}'),
      )));
  });
  if (error is UnAuthorizedException) {
    // Todo: clear session
    await Future.delayed(Duration(seconds: 1));
    navigateToScreen(LoginWidget(), context, isReplace: true);
  }
}

Future<Null> showMessage(String text, context) async {
  onWidgetDidBuild((){
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.lightGreen,
      content: ListTile(
        title: Text('$text'),
      )));
  });

}
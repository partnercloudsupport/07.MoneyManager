import 'package:flutter/material.dart';

/// Created by Huan.Huynh on 2019-07-05.
///
/// Copyright © 2019 teqnological. All rights reserved.

Future<String> navigateToScreen(Widget screen, BuildContext context,
  {bool isReplace = false}) async {
  if (isReplace) {
    return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => screen));
  } else {
    return Navigator.push(
      context, MaterialPageRoute(builder: (context) => screen));
  }
}

Future<dynamic> navigateToScreenWithResult(Widget screen, BuildContext context,
  {bool isReplace = false}) async {
  if (isReplace) {
    return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => screen));
  } else {
    return Navigator.push(
      context, MaterialPageRoute(builder: (context) => screen));
  }
}
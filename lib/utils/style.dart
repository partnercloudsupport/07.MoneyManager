import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFF8F8F8);
const Color secondaryColor = Color(0xFF333333);

ThemeData getAppTheme() {
  return ThemeData(
    fontFamily: 'Roboto',
    backgroundColor: primaryColor,
    primarySwatch: MyColors.mainColor,
    buttonColor: Color(0xFF49839D),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    dividerColor: Colors.white,
    toggleableActiveColor: Colors.green[800],
    brightness: Brightness.light,
    splashColor: Colors.transparent,
    accentColor: Colors.green[800],
    disabledColor: Colors.white,
    errorColor: Colors.red[400],
    hintColor: Colors.grey,
    cursorColor: Colors.grey,
    highlightColor: Colors.transparent,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.red,
      disabledColor: Color(0xFF333333),
      colorScheme: ColorScheme.light().copyWith(
        background: secondaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
      ),
      textTheme: ButtonTextTheme.normal,
    ),
    textTheme: TextTheme(
      title: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      caption: TextStyle(color: Colors.grey, fontSize: 22, fontFamily: 'Roboto'),
      headline: TextStyle(
          color: Colors.black,
          fontSize: 28.0,
          fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
      display1: TextStyle(color: secondaryColor, fontSize: 15, fontFamily: 'Roboto'),
      display2: TextStyle(color: secondaryColor, fontSize: 18, fontFamily: 'Roboto'),
      display3: TextStyle(color: secondaryColor, fontSize: 24, fontFamily: 'Roboto'),
      display4: TextStyle(color: secondaryColor, fontSize: 28, fontFamily: 'Roboto'),
    ),
  );
}

TextStyle dropDownTextStyle() {
  return TextStyle(color: Colors.black, fontSize: 22);
}

class MyColors {
  static MaterialColor mainColor = const MaterialColor(
    0xFF1D303D,
    const <int, Color> {
      50: Color(0xFF1D303D),
      100: Color(0xFF1D303D),
      200: Color(0xFF1D303D),
      300: Color(0xFF1D303D),
      400: Color(0xFF1D303D),
      500: Color(0xFF1D303D),
      600: Color(0xFF466F99),
      700: Color(0xFF466F99),
      800: Color(0xFF466F99),
      900: Color(0xFF466F99),
    });
  static MaterialColor backgroundColor = const MaterialColor(
    0xFF354C66,
    const <int, Color> {
      50: Color(0xFF354C66),
      100: Color(0xFF354C66),
      200: Color(0xFF354C66),
      300: Color(0xFF354C66),
      400: Color(0xFF354C66),
      500: Color(0xFF354C66),
      600: Color(0xFF354C66),
      700: Color(0xFF354C66),
      800: Color(0xFF354C66),
      900: Color(0xFF354C66),
    });

  static Color offColor = Colors.redAccent.withOpacity(0.5);
  static Color goOutColor = Colors.orangeAccent.withOpacity(0.5);
  static Color comeLateColor = Color(0xFF333333).withOpacity(0.5);
  static Color leaveEarlyColor = Color(0xFF0076FF).withOpacity(0.5);
  static Color urgentColor = Colors.red.withOpacity(0.5);

  static Color floatingButtonColor = Color(0xFFFF8C50);

  static Color getOffTypeColor(String offType) {
    switch (offType.toLowerCase()) {
      case 'go out':
        return goOutColor;
        break;
      case 'come late':
        return comeLateColor;
        break;
      case 'leave early':
        return leaveEarlyColor;
        break;
      case 'off':
      default:
        return offColor;
        break;
    }
  }
}
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Created by Huan.Huynh on 2019-07-02.
///
/// Copyright © 2019 teqnological. All rights reserved.

class MoneyManagerLocalizations {
  MoneyManagerLocalizations(this.locale);
  final Locale locale;
  static MoneyManagerLocalizations of(BuildContext context) {
    return Localizations.of<MoneyManagerLocalizations>(context, MoneyManagerLocalizations);
  }
  static Map<String, Map<String, String>> _localizedValues = {
    'vi': {
      'SignIn' : 'Đăng Nhập',
      'Account' : 'Tài khoản',
      'Password' : 'Mật Khẩu',
      'Old_Pass' : 'Mật khẩu hiện tại',
      'New_Password' : 'Mật khẩu mới',
      'New_Password_Confirm' : 'Nhập lại mật khẩu mới',

    },
    'en': {
      'SignIn' : 'Sign In',
      'Account' : 'Username',
      'Password' : 'Password',
      'Old_Pass' : 'Old Password',
      'New_Password' : 'New Password',
      'New_Password_Confirm' : 'Confirm new Password',

    },
  };

  String get signIn => _localizedValues[locale]['SignIn'];
  String get account => _localizedValues[locale]['Account'];
  String get password => _localizedValues[locale]['Password'];
  String get oldPass => _localizedValues[locale]['Old_Pass'];
  String get newPassword => _localizedValues[locale]['New_Password'];
  String get newPasswordConfirm => _localizedValues[locale]['New_Password_Confirm'];

}

class MoneyManagerLocalizationsDelegate extends LocalizationsDelegate<MoneyManagerLocalizations> {
  const MoneyManagerLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) => ['vi', 'en'].contains(locale.languageCode);

  @override
  Future<MoneyManagerLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<MoneyManagerLocalizations>(MoneyManagerLocalizations(locale));
  }
  @override
  bool shouldReload(MoneyManagerLocalizationsDelegate old) => false;
}
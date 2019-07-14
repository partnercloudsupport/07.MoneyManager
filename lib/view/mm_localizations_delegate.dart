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
      'New_Account_Confirm' : 'Bạn có muốn tạo tài khoản mới không ?',

      // Reset password
      'Reset_Password_Title' : 'Hướng dẫn tạo mật khẩu mới',
      'Reset_Password_Email' : 'Địa chỉ email',
      'Reset_Password' : 'Tạo mật khẩu mới',

      'Title.OverView' : 'Tổng quan',
      'Title.Accounts' : 'Tài khoản',
      'Title.OverView' : 'Vay nợ',
      'Title.OverView' : 'Khác',

      'No' : 'Không',
    },
    'en': {
      'SignIn' : 'Sign In',
      'Account' : 'Username',
      'Password' : 'Password',
      'Old_Pass' : 'Old Password',
      'New_Password' : 'New Password',
      'New_Password_Confirm' : 'Confirm new Password',
      'New_Account_Confirm' : 'Do you want to create new Account ?',

      // Reset password
      'Reset_Password_Title' : 'Reset Password Instructions',
      'Reset_Password_Email' : 'Email Address',
      'Reset_Password' : 'Reset Password',

      'Title.OverView' : 'Overview',
      'Title.Accounts' : 'Accounts',
      'Title.Loan' : 'Loan',
      'Title.Others' : 'Others',

      'No' : 'No',

    },
  };

  String get no => _localizedValues[locale.languageCode]['No'];

  String get signIn => _localizedValues[locale.languageCode]['SignIn'];
  String get account => _localizedValues[locale.languageCode]['Account'];
  String get password => _localizedValues[locale.languageCode]['Password'];
  String get oldPass => _localizedValues[locale.languageCode]['Old_Pass'];
  String get newPassword => _localizedValues[locale.languageCode]['New_Password'];
  String get newPasswordConfirm => _localizedValues[locale.languageCode]['New_Password_Confirm'];
  String get newAccountConfirm => _localizedValues[locale.languageCode]['New_Account_Confirm'];

  String get resetPasswordTitle => _localizedValues[locale.languageCode]['Reset_Password_Title'];
  String get resetPasswordEmail => _localizedValues[locale.languageCode]['Reset_Password_Email'];
  String get resetPassword => _localizedValues[locale.languageCode]['Reset_Password'];

  String get titleOverView => _localizedValues[locale.languageCode]['Title.OverView'];
  String get titleAccounts => _localizedValues[locale.languageCode]['Title.Accounts'];
  String get titleLoan => _localizedValues[locale.languageCode]['Title.Loan'];
  String get titleOthers => _localizedValues[locale.languageCode]['Title.Others'];

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
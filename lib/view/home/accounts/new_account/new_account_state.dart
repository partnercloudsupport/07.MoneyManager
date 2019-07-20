import 'package:base_bloc/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:money_manager/utils/countries/country.dart';
import 'package:money_manager/utils/string_utils.dart';

@immutable
class NewAccountState extends BaseState {
  final error;
  final bool isLoading;
  final String message;
  final String initialMoney;
  final String name;
  final AccountType accountType;
  final Country country;
  final String description;
  final bool isReport;
  final bool isSuccess;

  MaterialColor moneyColor()
    => inputtedValue(initialMoney) >= 0 ? Colors.blue : Colors.red;

  NewAccountState({
    this.isLoading = false,
    this.error,
    this.message,
    this.initialMoney,
    this.name,
    this.accountType,
    this.country,
    this.description,
    this.isReport,
    this.isSuccess,
  }) : super([isLoading, error, message,
    initialMoney, name, accountType, country, description, isReport,
    isSuccess
  ]);

  bool isValid() => name.isNotEmpty;

  NewAccountState copyWith({
    bool isLoading,
    var error,
    String message,
    String initialMoney,
    String name,
    AccountType accountType,
    Country country,
    String description,
    bool isReport,
    bool isSuccess,
  }) =>
    NewAccountState(
      isLoading: isLoading ?? false,
      error: error,
      message: message ?? this.message,
      initialMoney: initialMoney ?? this.initialMoney,
      name: name ?? this.name,
      accountType: accountType ?? this.accountType,
      country: country ?? this.country,
      description: description ?? this.description,
      isReport: isReport ?? this.isReport,
      isSuccess: isSuccess ?? this.isSuccess,
    );
}

enum AccountType{
  CASH,
  BANK,
  CREDIT_CARD,
  INVESTMENT,
  OTHERS,
}

AccountTypeWidget accountTypeToWidget(AccountType type) {
  switch(type) {
    case AccountType.CASH:
      return AccountTypeWidget('images/account_type/ic_cash.svg', 'Tiền mặt');
    case AccountType.BANK:
      return AccountTypeWidget('images/account_type/ic_bank.svg', 'Tài khoản ngân hàng');
    case AccountType.CREDIT_CARD:
      return AccountTypeWidget('images/account_type/ic_credit_card.svg', 'Thẻ tín dụng');
    case AccountType.INVESTMENT:
      return AccountTypeWidget('images/account_type/ic_invesment.svg', 'Tài khoản đầu tư');
    default:
      return AccountTypeWidget('images/account_type/ic_account_type_other.svg', 'Tài khoản khác');
  }
}

class AccountTypeWidget {
  final String asset;
  final String name;

  AccountTypeWidget(this.asset, this.name);
}


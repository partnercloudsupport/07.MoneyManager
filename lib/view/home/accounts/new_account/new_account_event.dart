import 'package:meta/meta.dart';
import 'package:base_bloc/base_bloc.dart';
import 'package:money_manager/utils/countries/country.dart';
import 'package:money_manager/view/home/accounts/new_account/new_account_state.dart';

@immutable
class NewAccountEvent extends BaseEvent {}

@immutable
class NewAccountEventInitialMoney extends BaseEvent {
  final String initialMoney;
  NewAccountEventInitialMoney(this.initialMoney) : super([initialMoney]);
}

@immutable
class NewAccountEventName extends BaseEvent {
  final String name;
  NewAccountEventName(this.name) : super([name]);
}

@immutable
class NewAccountEventAccountType extends BaseEvent {
  final AccountType accountType;
  NewAccountEventAccountType(this.accountType) : super([accountType]);
}

@immutable
class NewAccountEventCountry extends BaseEvent {
  final Country country;
  NewAccountEventCountry(this.country) : super([country]);
}

@immutable
class NewAccountEventDescription extends BaseEvent {
  final String description;
  NewAccountEventDescription(this.description) : super([description]);
}

@immutable
class NewAccountEventIsReport extends BaseEvent {
  final bool isReport;
  NewAccountEventIsReport(this.isReport) : super([isReport]);
}

@immutable
class NewAccountEventSave extends BaseEvent {}

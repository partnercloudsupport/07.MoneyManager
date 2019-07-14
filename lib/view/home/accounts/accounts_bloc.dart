import 'dart:async';
import 'package:base_bloc/base_bloc.dart';
import './accounts_widget_export.dart';

class AccountsBloc extends BaseBloc<AccountsState> {
  @override
  AccountsState get initialState => AccountsState();

  @override
  Stream<AccountsState> mapEventToState(BaseEvent event) async* {
    // TODO: implement mapEventToState

  }
}

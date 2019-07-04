import 'dart:async';
import 'package:base_bloc/base_bloc.dart';
import './login_widget_export.dart';

class LoginBloc extends BaseBloc<LoginState> {
  @override
  LoginState get initialState => LoginState();

  @override
  Stream<LoginState> mapEventToState(BaseEvent event) async* {
    // TODO: implement mapEventToState

  }
}

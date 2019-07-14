import 'dart:async';
import 'package:base_bloc/base_bloc.dart';
import './bloc.dart';

class ForgotPasswordPopupBloc extends BaseBloc<ForgotPasswordPopupState> {
  @override
  ForgotPasswordPopupState get initialState => ForgotPasswordPopupState();

  @override
  Stream<ForgotPasswordPopupState> mapEventToState(BaseEvent event) async* {

    if (event is ForgotPasswordEventEmail) {

      yield currentState.copyWith(email: event.email);

    } else if (event is ForgotPasswordEventRequest) {

    }
  }
}

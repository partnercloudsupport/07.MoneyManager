import 'package:base_bloc/base_bloc.dart';

class ForgotPasswordEventEmail extends BaseEvent {
  final String email;
  ForgotPasswordEventEmail(this.email) : super([email]);
}

class ForgotPasswordEventRequest extends BaseEvent {}
import 'package:meta/meta.dart';
import 'package:base_bloc/base_bloc.dart';

@immutable
class RegisterEvent extends BaseEvent {}

@immutable
class RegisterEventUserName extends BaseEvent {
  final String name;
  RegisterEventUserName(this.name) : super([name]);
}

@immutable
class RegisterEventEmail extends BaseEvent {
  final String email;
  RegisterEventEmail(this.email) : super([email]);
}

@immutable
class RegisterEventPassword extends BaseEvent {
  final String password;
  RegisterEventPassword(this.password) : super([password]);
}

@immutable
class RegisterEventObscureText extends BaseEvent {
  final bool isObscureText;
  RegisterEventObscureText(this.isObscureText) : super([isObscureText]);
}

@immutable
class RegisterEventRegister extends BaseEvent {}
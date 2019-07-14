import 'package:meta/meta.dart';
import 'package:base_bloc/base_bloc.dart';

@immutable
class LoginEvent extends BaseEvent {}

@immutable
class LoginEventEmail extends BaseEvent {
  final String email;
  LoginEventEmail(this.email) : super([email]);
}

@immutable
class LoginEventPassword extends BaseEvent {
  final String password;
  LoginEventPassword(this.password) : super([password]);
}

@immutable
class LoginEventObscureText extends BaseEvent {
  final bool isObscureText;
  LoginEventObscureText(this.isObscureText) : super([isObscureText]);
}

@immutable
class LoginEventLogin extends BaseEvent {}

@immutable
class LoginEventLoginGoogle extends BaseEvent {}

@immutable
class LoginEventLoginFacebook extends BaseEvent {}

@immutable
class LoginEventLoginTwitter extends BaseEvent {}

@immutable
class LoginEventLoginCreateAccount extends BaseEvent {}
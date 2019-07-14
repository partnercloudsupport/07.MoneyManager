import 'package:base_bloc/base_bloc.dart';
import 'package:meta/meta.dart';
import 'package:money_manager/repository/dto/session_dto.dart';

@immutable
class RegisterState extends BaseState {
  final error;
  final bool isLoading;
  final String username;
  final String email;
  final String password;
  final bool isObscureText;
  final String message;
  final SessionDto session;

  RegisterState({
    this.isLoading = false,
    this.error,
    this.username,
    this.email,
    this.password,
    this.isObscureText,
    this.message,
    this.session
  }) : super(
    [isLoading, error, username, email, password, isObscureText, message, session]);

  RegisterState copyWith({
    bool isLoading,
    var error,
    String username,
    String email,
    String password,
    bool isObscureText,
    String message,
    SessionDto session,
  }) =>
    RegisterState(
      isLoading: isLoading ?? false,
      error: error,
      message: message,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      isObscureText: isObscureText ?? this.isObscureText,
      session: session ?? this.session,
    );
}


import 'package:base_bloc/base_bloc.dart';
import 'package:meta/meta.dart';

@immutable
class ForgotPasswordPopupState extends BaseState {
    final error;
    final bool isLoading;
    final String email;
    final String message;

    ForgotPasswordPopupState({
      this.isLoading,
      this.error,
      this.email,
      this.message,
    })
      :super([isLoading, error, email, message]);

    ForgotPasswordPopupState copyWith({
      bool isLoading, var error,
      String email,
      String messageSuccess,
    }) =>
      ForgotPasswordPopupState(
        isLoading: isLoading ?? this.isLoading,
        error: error,
        email: email ?? this.email,
        message: message,
      );
}


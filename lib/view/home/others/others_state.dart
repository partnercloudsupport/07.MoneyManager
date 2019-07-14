import 'package:base_bloc/base_bloc.dart';
import 'package:meta/meta.dart';

@immutable
class OthersState extends BaseState {
  final error;
  final bool isLoading;
  final String message;
  final bool isLoggedOut;

  OthersState({
    this.isLoading = false,
    this.error,
    this.message,
    this.isLoggedOut,
  }) : super([isLoading, error, message, isLoggedOut]);

  OthersState copyWith({
    bool isLoading,
    var error,
    String message,
    bool isLoggedOut
  }) =>
    OthersState(
      isLoading: isLoading ?? false,
      error: error,
      message: message,
      isLoggedOut: isLoggedOut ?? this.isLoggedOut,
    );
}


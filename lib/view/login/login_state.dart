import 'package:base_bloc/base_bloc.dart';
import 'package:meta/meta.dart';

@immutable
class LoginState extends BaseState {
    final error;
    final bool isLoading;

    LoginState({
      this.isLoading = false,
      this.error,
    }) : super([isLoading, error]);

    LoginState copyWith({
      bool isLoading,
      var error,
    })
    => LoginState(
       isLoading: isLoading ?? false,
       error: error,
    );
}


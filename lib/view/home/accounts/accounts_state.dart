import 'package:base_bloc/base_bloc.dart';
import 'package:meta/meta.dart';

@immutable
class AccountsState extends BaseState {
    final error;
    final bool isLoading;

    AccountsState({
      this.isLoading = false,
      this.error,
    }) : super([isLoading, error]);

    AccountsState copyWith({
      bool isLoading,
      var error,
    })
    => AccountsState(
       isLoading: isLoading ?? false,
       error: error,
    );
}


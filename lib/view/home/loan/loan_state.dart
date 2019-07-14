import 'package:base_bloc/base_bloc.dart';
import 'package:meta/meta.dart';

@immutable
class LoanState extends BaseState {
    final error;
    final bool isLoading;

    LoanState({
      this.isLoading = false,
      this.error,
    }) : super([isLoading, error]);

    LoanState copyWith({
      bool isLoading,
      var error,
    })
    => LoanState(
       isLoading: isLoading ?? false,
       error: error,
    );
}


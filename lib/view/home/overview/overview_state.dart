import 'package:base_bloc/base_bloc.dart';
import 'package:meta/meta.dart';

@immutable
class OverviewState extends BaseState {
    final error;
    final bool isLoading;

    OverviewState({
      this.isLoading = false,
      this.error,
    }) : super([isLoading, error]);

    OverviewState copyWith({
      bool isLoading,
      var error,
    })
    => OverviewState(
       isLoading: isLoading ?? false,
       error: error,
    );
}


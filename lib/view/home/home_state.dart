import 'package:base_bloc/base_bloc.dart';
import 'package:meta/meta.dart';

@immutable
class HomeState extends BaseState {
    final error;
    final bool isLoading;

    HomeState({
      this.isLoading = false,
      this.error,
    }) : super([isLoading, error]);

    HomeState copyWith({
      bool isLoading,
      var error,
    })
    => HomeState(
       isLoading: isLoading ?? false,
       error: error,
    );
}


import 'package:base_bloc/base_bloc.dart';
import 'package:meta/meta.dart';

@immutable
class HomeState extends BaseState {
  final error;
  final bool isLoading;
  final int tabIndex;

  HomeState({
    this.isLoading = false,
    this.error,
    this.tabIndex,
  }) : super([isLoading, error, tabIndex]);

  HomeState copyWith({
    bool isLoading,
    var error,
    int tabIndex,
  }) =>
    HomeState(
      isLoading: isLoading ?? false,
      error: error,
      tabIndex: tabIndex ?? this.tabIndex,
    );
}


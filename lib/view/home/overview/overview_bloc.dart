import 'dart:async';
import 'package:base_bloc/base_bloc.dart';
import './overview_widget_export.dart';

class OverviewBloc extends BaseBloc<OverviewState> {
  @override
  OverviewState get initialState => OverviewState();

  @override
  Stream<OverviewState> mapEventToState(BaseEvent event) async* {
    // TODO: implement mapEventToState

  }
}

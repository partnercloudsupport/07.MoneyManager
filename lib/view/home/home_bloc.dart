import 'dart:async';
import 'package:base_bloc/base_bloc.dart';
import './home_widget_export.dart';

class HomeBloc extends BaseBloc<HomeState> {
  @override
  HomeState get initialState => HomeState();

  @override
  Stream<HomeState> mapEventToState(BaseEvent event) async* {
    // TODO: implement mapEventToState

  }
}

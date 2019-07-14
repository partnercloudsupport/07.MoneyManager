import 'dart:async';
import 'package:base_bloc/base_bloc.dart';
import 'package:money_manager/utils/prefs.dart';
import './others_widget_export.dart';

class OthersBloc extends BaseBloc<OthersState> {
  @override
  OthersState get initialState => OthersState(
    isLoggedOut: false
  );

  @override
  Stream<OthersState> mapEventToState(BaseEvent event) async* {
    // TODO: implement mapEventToState

    if(event is OthersEventLogout) {
      saveSession(null);
      yield currentState.copyWith(isLoggedOut: true);
    }
  }
}

import 'dart:async';
import 'package:base_bloc/base_bloc.dart';
import './loan_widget_export.dart';

class LoanBloc extends BaseBloc<LoanState> {
  @override
  LoanState get initialState => LoanState();

  @override
  Stream<LoanState> mapEventToState(BaseEvent event) async* {
    // TODO: implement mapEventToState

  }
}

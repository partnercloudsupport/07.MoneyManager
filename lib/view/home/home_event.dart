import 'package:meta/meta.dart';
import 'package:base_bloc/base_bloc.dart';

@immutable
class HomeEvent extends BaseEvent {}

@immutable
class HomeEventChangTab extends BaseEvent {
  final int tabIndex;
  HomeEventChangTab({this.tabIndex}) : super([tabIndex]);
}

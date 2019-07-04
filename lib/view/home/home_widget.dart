import 'package:base_bloc/base_bloc.dart';
import 'package:flutter/material.dart';
import './home_widget_export.dart';

class HomeWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends BaseBlocState<HomeWidget> {

  BuildContext _context;

  @override
  Widget build(BuildContext context) => BaseBlocBuilder<HomeState>(bloc, _buildBody);

  @override
  BaseBloc createBloc() => HomeBloc();

  Widget _buildBody(BuildContext context, HomeState state) {

    return Container(
      child: SafeArea(
        child: Scaffold(
          body: Builder(builder: (BuildContext context) {
            _context = context;
            return Container(
            );
          }),
        ),
      ),
    );
  }

}


import 'package:base_bloc/base_bloc.dart';
import 'package:flutter/material.dart';
import './login_widget_export.dart';

class LoginWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends BaseBlocState<LoginWidget> {

  BuildContext _context;

  @override
  Widget build(BuildContext context) => BaseBlocBuilder<LoginState>(bloc, _buildBody);

  @override
  BaseBloc createBloc() => LoginBloc();

  Widget _buildBody(BuildContext context, LoginState state) {

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


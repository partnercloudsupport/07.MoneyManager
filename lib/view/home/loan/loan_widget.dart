import 'package:base_bloc/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/utils/style.dart';
import 'package:money_manager/view/mm_localizations_delegate.dart';
import './loan_widget_export.dart';

class LoanWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoanWidgetState();
}

class _LoanWidgetState extends BaseBlocState<LoanWidget> {

  BuildContext _context;

  @override
  Widget build(BuildContext context) => BaseBlocBuilder<LoanState>(bloc, _buildBody);

  @override
  BaseBloc createBloc() => LoanBloc();

  Widget _buildBody(BuildContext context, LoanState state) {

    return Container(
      child: SafeArea(
        child: Scaffold(
          body: Builder(builder: (BuildContext context) {
            _context = context;
            return Container(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    elevation: 3,
                    backgroundColor: MyColors.mainColor,
                    expandedHeight: 56,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(MoneyManagerLocalizations.of(context).titleLoan,
                        style: Theme.of(context).textTheme.title
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, i) {
                      return Container(
                        height: 50,
                        child: Center(
                          child: Text('$i'),
                        ),
                      );
                    }, childCount: 100)
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

}


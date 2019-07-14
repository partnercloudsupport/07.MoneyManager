import 'package:base_bloc/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/utils/style.dart';
import 'package:money_manager/view/mm_localizations_delegate.dart';
import './accounts_widget_export.dart';

class AccountsWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AccountsWidgetState();
}

class _AccountsWidgetState extends BaseBlocState<AccountsWidget> {

  BuildContext _context;

  @override
  Widget build(BuildContext context) => BaseBlocBuilder<AccountsState>(bloc, _buildBody);

  @override
  BaseBloc createBloc() => AccountsBloc();

  Widget _buildBody(BuildContext context, AccountsState state) {

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
                      title: Text(MoneyManagerLocalizations.of(context).titleAccounts,
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


import 'package:base_bloc/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/utils/navigation.dart';
import 'package:money_manager/utils/style.dart';
import 'package:money_manager/view/home/accounts/new_account/new_account_widget_export.dart';
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
                      title: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          shape: BoxShape.rectangle
                        ),
                        child: Text(MoneyManagerLocalizations.of(context).titleAccounts,
                          style: Theme.of(context).textTheme.title
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      IconButton(icon: Icon(Icons.add),
                      onPressed: () => navigateToScreenWithResult(NewAccountWidget(), context),),
                    ],
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


import 'package:base_bloc/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/utils/style.dart';
import 'package:money_manager/view/mm_localizations_delegate.dart';
import './overview_widget_export.dart';

class OverviewWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _OverviewWidgetState();
}

class _OverviewWidgetState extends BaseBlocState<OverviewWidget> {

  BuildContext _context;

  @override
  Widget build(BuildContext context) => BaseBlocBuilder<OverviewState>(bloc, _buildBody);

  @override
  BaseBloc createBloc() => OverviewBloc();

  Widget _buildBody(BuildContext context, OverviewState state) {

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
                    leading: IconButton(icon: Icon(Icons.tune), onPressed: null),
                    actions: <Widget>[
                      IconButton(icon: Icon(Icons.poll), onPressed: null)
                    ],
                    backgroundColor: MyColors.mainColor,
                    expandedHeight: 56,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(MoneyManagerLocalizations.of(context).titleOverView,
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


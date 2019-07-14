import 'package:base_bloc/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_manager/utils/navigation.dart';
import 'package:money_manager/utils/snack_bar.dart';
import 'package:money_manager/utils/style.dart';
import 'package:money_manager/utils/utils.dart';
import 'package:money_manager/view/login/login_widget.dart';
import 'package:money_manager/view/mm_localizations_delegate.dart';
import './others_widget_export.dart';

class OthersWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _OthersWidgetState();
}

class _OthersWidgetState extends BaseBlocState<OthersWidget> {

  BuildContext _context;

  @override
  Widget build(BuildContext context) => BaseBlocBuilder<OthersState>(bloc, _buildBody);

  @override
  BaseBloc createBloc() => OthersBloc();

  Widget _buildBody(BuildContext context, OthersState state) {

    if(state.isLoggedOut) {
      onWidgetDidBuild(() {
        navigateToScreen(
          LoginWidget(),
          context,
          isReplace: true);
      });
    }

    if(state.error != null) {
      showError(state.error, _context);
      dispatch(InitialEvent());
    }

    if(state.message != null) {
      showMessage(state.message, _context);
      dispatch(InitialEvent());
    }

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
                        decoration: new BoxDecoration(
                          border: new Border.all(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          shape: BoxShape.rectangle
                        ),
                        child: Text(MoneyManagerLocalizations.of(context).titleOthers,
                          style: Theme.of(context).textTheme.title
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      IconButton(icon: SvgPicture.asset(
                        'images/ic_logout.svg',
                        color: Colors.white,
                        height: 30,
                        width: 20,
                      ), onPressed: () => dispatch(OthersEventLogout())),
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


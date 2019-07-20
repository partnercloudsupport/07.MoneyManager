import 'package:base_bloc/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:money_manager/repository/dto/session_dto.dart';
import 'package:money_manager/utils/money_manager_icons.dart';
import 'package:money_manager/utils/style.dart';
import 'package:money_manager/view/home/accounts/accounts_widget.dart';
import 'package:money_manager/view/home/loan/loan_widget.dart';
import 'package:money_manager/view/home/others/others_widget.dart';
import 'package:money_manager/view/home/overview/overview_widget.dart';
import 'package:money_manager/view/mm_localizations_delegate.dart';
import './home_widget_export.dart';

class HomeWidget extends StatefulWidget{

  final SessionDto session;

  const HomeWidget({Key key, this.session}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends BaseBlocState<HomeWidget> with TickerProviderStateMixin {

  BuildContext _context;

  @override
  Widget build(BuildContext context) => BaseBlocBuilder<HomeState>(bloc, _buildBody);

  @override
  BaseBloc createBloc() => HomeBloc();
  TabController _tabController;
  List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = _getListPage();
    _tabController = TabController(vsync: this, length: pages.length);
  }

  @override
  void dispose() {
    pages.clear();
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    _updateStatusBar();
    _tabController.animateTo(state.tabIndex);
    return Container(
      color: MyColors.mainColor,
      child: SafeArea(
        child: Scaffold(
          body: TabBarView(children: pages, controller: _tabController,
            physics: NeverScrollableScrollPhysics()),
          bottomNavigationBar: BottomNavyBar(
            backgroundColor: MyColors.mainColor,
            selectedIndex: state.tabIndex,
            showElevation: true,
            onItemSelected: (index) => dispatch(HomeEventChangTab(tabIndex: index)),
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.desktop_mac),
                title: Text(MoneyManagerLocalizations.of(context).titleOverView),
                activeColor: Colors.white,
              ),
              BottomNavyBarItem(
                icon: Icon(MoneyManager.wallet),
                title: Text(MoneyManagerLocalizations.of(context).titleAccounts),
                activeColor: Colors.white
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.description),
                title: Text(MoneyManagerLocalizations.of(context).titleLoan),
                activeColor: Colors.white
              ),
              BottomNavyBarItem(
                icon: Icon(Icons.more_horiz),
                title: Text(MoneyManagerLocalizations.of(context).titleOthers),
                activeColor: Colors.white
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateStatusBar() async {
    try {
      await FlutterStatusbarManager.setStyle(StatusBarStyle.LIGHT_CONTENT);
      await FlutterStatusbarManager.setNavigationBarStyle(
        NavigationBarStyle.LIGHT);
    } catch (e) {
      print('_updateStatusBar ----> $e');
    }
  }

  _getListPage() => [
    OverviewWidget(),
    AccountsWidget(),
    LoanWidget(),
    OthersWidget(),
  ];
}


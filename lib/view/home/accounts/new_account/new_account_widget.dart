import 'package:base_bloc/base_bloc.dart';
import 'package:cool_ui/cool_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:load/load.dart';
import 'package:money_manager/utils/countries/country_picker_dialog.dart';
import 'package:money_manager/utils/money_manager_icons.dart';
import 'package:money_manager/utils/calculate_number_keyboard.dart';
import 'package:money_manager/utils/snack_bar.dart';
import 'package:money_manager/utils/string_utils.dart';
import 'package:money_manager/utils/style.dart';
import 'package:money_manager/utils/utils.dart';
import 'package:money_manager/utils/widgets/border_input_textfield.dart';
import 'package:money_manager/utils/widgets/selection_dialog.dart';
import 'package:money_manager/view/mm_localizations_delegate.dart';

import './new_account_widget_export.dart';

class NewAccountWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewAccountWidgetState();
}

class _NewAccountWidgetState extends BaseBlocState<NewAccountWidget> {

  BuildContext _context;

  final _moneyController = TextEditingController();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  @override
  Widget build(BuildContext context) =>
    BaseBlocBuilder<NewAccountState>(bloc, _buildBody);

  @override
  BaseBloc createBloc() => NewAccountBloc();

  @override
  void initState() {
    super.initState();

    dispatch(InitialEvent());

    _moneyController.addListener(() {
      dispatch(NewAccountEventInitialMoney(_moneyController.text));
    });

    _nameController.addListener(() {
      var text = _nameController.text;
      dispatch(NewAccountEventName(text));
    });

    _descController.addListener(() {
      var text = _descController.text;
      dispatch(NewAccountEventDescription(text));
    });
  }

  Widget _buildBody(BuildContext context, NewAccountState state) {
    _updateStatusBar();

    String _text = state.initialMoney;
    var inputted = _text.replaceAll(',', '').split(RegExp(r"(\W+)")).where((element) => element.isNotEmpty).toList();
    var inputtedSign = _text.replaceAll(',', '').split(RegExp(r"(\w+)")).where((element) => element.isNotEmpty).toList();

    String _newText = '';
    for(var i = 0; i < inputted.length; i++) {
      String _formatted;
      if(i == 0) {
        _formatted = toMoney(int.parse(inputted[i].trim()) * (_text.startsWith('-') ? -1 : 1));
      } else {
        _formatted = toMoney(int.parse(inputted[i].trim()));
      }
      _newText += _formatted;
      debugPrint(_newText);
      if(_text.startsWith('-')) {
        if(i + 1 < inputtedSign.length) {
          _newText += inputtedSign[i + 1];
        }
      } else if(i< inputtedSign.length) {
        _newText += inputtedSign[i];
      }
    }

    if(_newText.isEmpty) _newText = '0';

    if(_moneyController.selection.baseOffset <= _newText.length) {
      debugPrint('New offset = _newText.length = ${_newText.length}');
    } else {
      debugPrint('New offset = _moneyController.selection.baseOffset = ${_moneyController.selection.baseOffset}');
    }
    _moneyController.value = TextEditingValue(
      text: _newText, selection: TextSelection.collapsed(offset:_newText.length));

    if (state.error != null) {
      showError(state.error, _context);
      dispatch(InitialEvent());
    }

    if (state.message != null) {
      showMessage(state.message, _context);
      dispatch(InitialEvent());
    }

    if (state.isLoading) {
      showLoadingDialog();
    } else {
      hideLoadingDialog();
    }

    if(state.isSuccess) {
      Navigator.of(context).pop('success');
    }

    return Container(
      child: SafeArea(
        child: KeyboardMediaQuery(
          child: Builder(builder: (ctx) {
          CoolKeyboard.init(ctx);
            return Scaffold(
            appBar: AppBar(
              elevation: 3,
              centerTitle: true,
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  shape: BoxShape.rectangle
                ),
                child: Text(MoneyManagerLocalizations
                  .of(context)
                  .newAccountTitle,
                  style: Theme
                    .of(context)
                    .textTheme
                    .title
                ),
              ),
              leading: IconButton(icon: SvgPicture.asset(
                'images/ic_back.svg',
                height: 20,
              ), onPressed: () => Navigator.of(context).pop(),),
              actions: <Widget>[
                IconButton(
                  icon: SvgPicture.asset(
                    'images/ic_done.svg',
                    height: 24,
                    color: state.isValid() ? Colors.white : Colors.grey.withOpacity(0.2),
                  ),
                  onPressed: () => dispatch(NewAccountEventSave()),
                )
              ],
            ),
            body: Builder(builder: (BuildContext context) {
              _context = context;
              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(2.0, 3.0),
                              blurRadius: 3.0,
                              spreadRadius: 1

                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('• ${MoneyManagerLocalizations
                              .of(context)
                              .newAccountInitialMoney}',
                              style: TextStyle(fontSize: 16),),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: BorderInputTextField(
                                    icon: Icon(MoneyManager.money,),
                                    controller: _moneyController,
                                    maxLines: 1,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: CalculateNumberKeyboard.inputType,
                                    textColor: state.moneyColor(),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Text(state.country.symbol,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.blue),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(height: 16, color: Colors.grey.withOpacity(0.1),),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: BorderInputTextField(
                                icon: Icon(MoneyManager.wallet),
                                hintText: MoneyManagerLocalizations
                                  .of(context)
                                  .newAccountName,
                                keyboardType: TextInputType.text,
                                controller: _nameController,
                                maxLines: 1,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            Divider(height: 0.3, color: Colors.grey, indent: 16,),
                            InkWell(
                              onTap: () => _selectAccountType(),
                              child: Container(
                                height: 50,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 30,
                                      height: 30,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: MyColors.mainColor,
                                      ),
                                      child: SvgPicture.asset(
                                        accountTypeToWidget(state.accountType)
                                          .asset,),
                                    ),
                                    SizedBox(width: 8,),
                                    Expanded(
                                      child: Text(
                                        accountTypeToWidget(state.accountType)
                                          .name,
                                        style: TextStyle(fontSize: 18),),
                                    ),
                                    Icon(Icons.keyboard_arrow_right,
                                      color: Colors.grey,),
                                  ],
                                ),
                              ),
                            ),
                            Divider(height: 0.3, color: Colors.grey, indent: 16,),
                            InkWell(
                              onTap: () => _selectCurrency(state),
                              child: Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 30,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3)),
                                        border: Border.all(width: 0.1,),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(3),
                                        child: SizedBox(
                                          width: 30, height: 20,
                                          child: CountryPickerUtils
                                            .getDefaultFlagImage(state.country)),
                                      ),
                                    ),
                                    SizedBox(width: 8,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                        children: <Widget>[
                                          SizedBox(height: 5,),
                                          Text(state.country.name,
                                            style: TextStyle(fontSize: 18),),
                                          SizedBox(height: 3,),
                                          Text(
                                            '${state.country.currency} : ${state
                                              .country.symbol}',
                                            style: TextStyle(
                                              fontSize: 14, color: Colors.grey),),
                                          SizedBox(height: 5,),
                                        ],
                                      ),
                                    ),
                                    Icon(Icons.keyboard_arrow_right,
                                      color: Colors.grey,),
                                  ],
                                ),
                              ),
                            ),
                            Divider(height: 0.3, color: Colors.grey, indent: 16,),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: BorderInputTextField(
                                icon: Icon(Icons.description),
                                hintText: MoneyManagerLocalizations
                                  .of(context)
                                  .description,
                                keyboardType: TextInputType.text,
                                controller: _descController,
                                maxLines: 1,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            Divider(height: 0.3, color: Colors.grey, indent: 16,),
                            Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(MoneyManagerLocalizations
                                      .of(context)
                                      .newAccountIsReport,
                                      style: TextStyle(fontSize: 18),),
                                  ),
                                  CupertinoSwitch(
                                    activeColor: MyColors.primaryGreen,
                                    value: state.isReport,
                                    onChanged: (isReport) =>
                                      dispatch(
                                        NewAccountEventIsReport(isReport))),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
          }
          ),
        )
      ),
    );
  }

  Future<void> _updateStatusBar() async {
    try {
      await FlutterStatusbarManager.setColor(MyColors.mainColor);
      await FlutterStatusbarManager.setStyle(StatusBarStyle.LIGHT_CONTENT);
      await FlutterStatusbarManager.setNavigationBarColor(MyColors.mainColor);
      await FlutterStatusbarManager.setNavigationBarStyle(
        NavigationBarStyle.LIGHT);
    } catch (e) {
      print('_updateStatusBar ----> $e');
    }
  }

  _selectAccountType() async {
    final result = await Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) =>
        SelectionDialog(
          data: AccountType.values,
          itemHeight: 80,
          builder: (BuildContext cxt, int index) {
            return Container(
              height: 80,
              child: Row(
                children: <Widget>[
                  SizedBox(width: 16,),
                  Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MyColors.mainColor,
                    ),
                    child: SvgPicture.asset(
                      accountTypeToWidget(AccountType.values[index]).asset,
                      height: 40, width: 40,),
                  ),
                  SizedBox(width: 16,),
                  Expanded(child: Text(
                    accountTypeToWidget(AccountType.values[index]).name,
                    style: TextStyle(fontSize: 18),)),
                ],
              ),
            );
          },
        ))
    );

    dispatch(NewAccountEventAccountType(result));
  }

  _selectCurrency(NewAccountState state) async {
    final result = await Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) =>
        CountryPickerDialog(selected: state.country.isoCode,)
    ));

    dispatch(NewAccountEventCountry(result));
  }
}


import 'dart:async';
import 'package:base_bloc/base_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_manager/repository/dto/account_dto.dart';
import 'package:money_manager/utils/countries/country.dart';
import 'package:money_manager/utils/prefs.dart';
import './new_account_widget_export.dart';

class NewAccountBloc extends BaseBloc<NewAccountState> {
  @override
  NewAccountState get initialState => NewAccountState(
    initialMoney: '0',
    name: '',
    accountType: AccountType.CASH,
    country: Country(
      isoCode: "VN",
      currency: "VND",
      symbol: 'đ',
      name: "Vietnamese Dong",
      iso3Code: "VNM",
    ),
    description: '',
    isReport: true,
    isSuccess: false,
    isLoading: false,
  );

  @override
  Stream<NewAccountState> mapEventToState(BaseEvent event) async* {
    // TODO: implement mapEventToState

    if(event is NewAccountEventInitialMoney) {
      yield currentState.copyWith(initialMoney: event.initialMoney);
    } else if(event is NewAccountEventName) {
      yield currentState.copyWith(name: event.name);
    } else if(event is NewAccountEventAccountType) {
      yield currentState.copyWith(accountType: event.accountType);
    } else if(event is NewAccountEventCountry) {
      yield currentState.copyWith(country: event.country);
    } else if(event is NewAccountEventDescription) {
      yield currentState.copyWith(description: event.description);
    } else if(event is NewAccountEventIsReport) {
      yield currentState.copyWith(isReport: event.isReport);
    } else if(event is NewAccountEventSave){
      yield currentState.copyWith(isLoading: true);

      // Check name is available or not.
      final snapshotExisted = Firestore.instance.collection('accounts')
        .where('name', isEqualTo: currentState.name)
        .where('user_id', isEqualTo: getSession().id)
        .snapshots();
      final QuerySnapshot documentExisted = await snapshotExisted.first;
      if (documentExisted.documents.length > 0) {
        yield currentState.copyWith(error: 'This account is already existed. please try another name.');
        return;
      }

      // Create new account
      CollectionReference ref = Firestore.instance.collection("accounts");
      final accountID = ref.document().documentID;
      await Firestore.instance.collection('accounts').document(accountID)
        .setData(AccountDto(
        id: accountID,
        name: currentState.name,
        initialMoney: currentState.initialMoney,
        currentMoney: currentState.initialMoney,
        accountType: currentState.accountType.toString(),
        country: currentState.country.isoCode,
        description: currentState.description,
        isReport: currentState.isReport,
        userId: getSession().id,
        isEnable: true
      ).toJson())
      .catchError(handleError);

      yield currentState.copyWith(isSuccess: true);
    }
  }

  handleError(var error) async* {
    yield currentState.copyWith(error: error);
  }
}

import 'dart:async';
import 'package:base_bloc/base_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_manager/repository/dto/session_dto.dart';
import './register_widget_export.dart';

class RegisterBloc extends BaseBloc<RegisterState> {
  @override
  RegisterState get initialState => RegisterState(
    username: '',
    email: '',
    password: '',
    isObscureText: true,
  );

  @override
  Stream<RegisterState> mapEventToState(BaseEvent event) async* {
    // TODO: implement mapEventToState

    if (event is RegisterEventUserName) {
      yield currentState.copyWith(username: event.name);
    } else if (event is RegisterEventEmail) {
      yield currentState.copyWith(email: event.email);
    } else if (event is RegisterEventPassword) {
      yield currentState.copyWith(password: event.password);
    } else if (event is RegisterEventObscureText) {
      yield currentState.copyWith(isObscureText: event.isObscureText);
    } else if (event is RegisterEventRegister) {
      // Check email is available or not.
      final snapshotExisted = Firestore.instance.collection('users')
        .where('email', isEqualTo: currentState.email)
        .snapshots();
      final QuerySnapshot documentExisted = await snapshotExisted.first;
      if (documentExisted.documents.length > 0) {
        yield currentState.copyWith(error: 'This email is used. please try another.');
        return;
      }

      // Create new account
      CollectionReference ref = Firestore.instance.collection("users");
      final userID = ref.document().documentID;
      await Firestore.instance.collection('users').document(userID)
        .setData(SessionDto(
        id: userID,
        email: currentState.email,
        name: currentState.username,
        password: currentState.password,
        createdDay: DateTime.now(),
      ).toJson())
      .catchError(handleError);

      // Retries created account.
      final snapshot = Firestore.instance.collection('users')
        .where('email', isEqualTo: currentState.email)
        .where('password', isEqualTo: currentState.password)
        .snapshots();
      final QuerySnapshot document = await snapshot.first;
      if (document.documents.length > 0) {
        yield currentState.copyWith(session: SessionDto.fromJson(document.documents[0].data));
      } else {
        yield currentState.copyWith(error: 'Cannot login');
      }

    } else if (event is ErrorEvent) {
      yield currentState.copyWith(error: event.error);
    } else if (event is InitialEvent) {
      yield currentState.copyWith(error: null, message: null);
    }
  }

  handleError(var error) async* {
    yield currentState.copyWith(error: error);
  }
}

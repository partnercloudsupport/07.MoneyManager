import 'dart:async';
import 'dart:convert';
import 'package:base_bloc/base_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_twitter/flutter_twitter.dart';
import 'package:http/http.dart' as http;
import 'package:money_manager/repository/dto/session_dto.dart';
import './login_widget_export.dart';

class LoginBloc extends BaseBloc<LoginState> {
  @override
  LoginState get initialState =>
    LoginState(
      email: '',
      password: '',
      isLoading: false,
      isObscureText: true,
    );

  @override
  Stream<LoginState> mapEventToState(BaseEvent event) async* {
    // TODO: implement mapEventToState

    if (event is LoginEventEmail) {
      yield currentState.copyWith(email: event.email);
    } else if (event is LoginEventPassword) {
      if(event.password != currentState.password) {
        yield currentState.copyWith(password: event.password);
      }
    } else if (event is LoginEventObscureText) {
      yield currentState.copyWith(isObscureText: event.isObscureText);
    } else if (event is LoginEventLogin) {

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
    } else if (event is LoginEventLoginGoogle) {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser
        .authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      yield currentState.copyWith(isLoading: true);

      final FirebaseUser user = await FirebaseAuth.instance
        .signInWithCredential(credential)
        .catchError(handleError);

      if (user != null) {
        print("signed in " + user.displayName);
        final snapshot = Firestore.instance.collection('users').where(
          'email', isEqualTo: user.email).snapshots();
        final QuerySnapshot document = await snapshot.first;
        if (document.documents.length > 0) {
          yield currentState.copyWith(session: SessionDto.fromJson(document.documents[0].data));
        } else {
          yield currentState.copyWith(googleUser: user);
        }
      }
    } else if (event is LoginEventLoginFacebook) {
      final facebookLogin = FacebookLogin();
      final result = await facebookLogin.logInWithReadPermissions(['email']);

      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final token = result.accessToken.token;
          final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
          final profile = json.decode(graphResponse.body);
          print("signed in: $profile");

          // Confirm email is available
          final snapshot = Firestore.instance.collection('users').where(
            'email', isEqualTo: profile['email']).snapshots();
          final QuerySnapshot document = await snapshot.first;
          if (document.documents.length > 0) {
            yield currentState.copyWith(session: SessionDto.fromJson(document.documents[0].data));
          } else {
            yield currentState.copyWith(facebookUser: FacebookUserDto(
              facebookId: profile['id'],
              email: profile['email'],
              name: profile['name'],
              facebookToken: result.accessToken.token)
            );
          }
          break;
        case FacebookLoginStatus.cancelledByUser:
          yield currentState.copyWith(error: 'Cancelled');
          break;
        case FacebookLoginStatus.error:
          yield currentState.copyWith(error: result.errorMessage);
          break;
      }
    } else if (event is LoginEventLoginTwitter) {
      var twitterLogin = TwitterLogin(
        consumerKey: '984PsKKk9PhjFukhMLzV8o6Nt',
        consumerSecret: 'zlcMgbuV5vyAEc4g8u4l9Uf1XhFBq4jN4TmhK60Kon4vBFL5ZP',
      );

      final TwitterLoginResult result = await twitterLogin.authorize();

      switch (result.status) {
        case TwitterLoginStatus.loggedIn:
          var session = result.session;
          print("signed in: $session");

          // Confirm email is available
          final snapshot = Firestore.instance.collection('users')
            .where('twitterId', isEqualTo: session.userId,)
            .where('twitterToken', isEqualTo: session.token,)
            .where('twitterSecretToken', isEqualTo: session.secret,
          ).snapshots();
          final QuerySnapshot document = await snapshot.first;
          if (document.documents.length > 0) {
            yield currentState.copyWith(session: SessionDto.fromJson(document.documents[0].data));
          } else {
            yield currentState.copyWith(twitterUser: TwitterUserDto(
              twitterId: session.userId,
              twitterToken: session.token,
              twitterSecretToken: session.secret,
              name: session.username)
            );
          }
          break;
        case TwitterLoginStatus.cancelledByUser:
          yield currentState.copyWith(error: 'Cancelled');
          break;
        case TwitterLoginStatus.error:
          yield currentState.copyWith(error: result.errorMessage);
          break;
      }
    } else if (event is LoginEventLoginCreateAccount) {
      CollectionReference ref = Firestore.instance.collection("users");
      final userID = ref.document().documentID;
      Firestore.instance.collection('users').document(userID)
        .setData(SessionDto(
        id: userID,
        email: currentState.googleUser?.email ?? currentState.facebookUser?.email ?? '',
        name: currentState.googleUser?.displayName ?? currentState.facebookUser?.name ?? currentState.twitterUser.name,
        facebookId: currentState.facebookUser?.facebookId ?? null,
        facebookToken: currentState.facebookUser?.facebookToken ?? null,
        twitterId: currentState.twitterUser?.twitterId ?? null,
        twitterToken: currentState.twitterUser?.twitterToken ?? null,
        twitterSecretToken: currentState.twitterUser?.twitterSecretToken ?? null,
        createdDay: DateTime.now(),
        address: 'Ho Chi Minh City'
        ).toJson()
      )
      .catchError(handleError);

      // Retries created account.
      var snapshot;
      if(currentState.googleUser != null) {
        snapshot = Firestore.instance.collection('users')
          .where('email', isEqualTo: currentState.googleUser.email)
          .snapshots();
      } else if(currentState.facebookUser != null){
        snapshot = Firestore.instance.collection('users')
          .where('email', isEqualTo: currentState.facebookUser.email)
          .where('facebookId', isEqualTo: currentState.facebookUser.facebookId)
          .snapshots();
      } else if(currentState.twitterUser != null){
        snapshot = Firestore.instance.collection('users')
          .where('twitterId', isEqualTo: currentState.twitterUser.twitterId)
          .where('twitterToken', isEqualTo: currentState.twitterUser.twitterToken)
          .where('twitterSecretToken', isEqualTo: currentState.twitterUser.twitterSecretToken)
          .snapshots();
      }

      final QuerySnapshot document = await snapshot.first;
      if (document.documents.length > 0) {
        yield currentState.copyWith(session: SessionDto.fromJson(document.documents[0].data));
      } else {
        yield currentState.copyWith(error: 'Cannot login');
      }
    }
  }

  handleError(var error) async* {
    yield currentState.copyWith(error: error);
  }
}

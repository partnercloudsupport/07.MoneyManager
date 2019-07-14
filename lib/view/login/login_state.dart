import 'package:base_bloc/base_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:money_manager/repository/dto/session_dto.dart';

@immutable
class LoginState extends BaseState {
  final error;
  final bool isLoading;
  final String email;
  final String password;
  final bool isObscureText;
  final SessionDto session;
  final String message;
  final FirebaseUser googleUser;
  final FacebookUserDto facebookUser;
  final TwitterUserDto twitterUser;

  LoginState({
    this.isLoading = false,
    this.error, this.message,
    this.email, this.password, this.isObscureText, this.session,
    this.googleUser, this.facebookUser, this.twitterUser,
  }) : super(
    [isLoading, error, message,
      email, password, isObscureText, session,
      googleUser, facebookUser, twitterUser]);

  LoginState copyWith({
    bool isLoading,
    var error,
    String message,
    String email,
    String password,
    bool isObscureText,
    SessionDto session,
    FirebaseUser googleUser,
    FacebookUserDto facebookUser,
    TwitterUserDto twitterUser,
  }) =>
    LoginState(
      isLoading: isLoading ?? false,
      error: error,
      message: message,
      email: email ?? this.email,
      password: password ?? this.password,
      isObscureText: isObscureText ?? this.isObscureText,
      session: session ?? this.session,
      googleUser: googleUser ?? this.googleUser,
      facebookUser: facebookUser ?? this.facebookUser,
      twitterUser: twitterUser ?? this.twitterUser,
    );
}

class FacebookUserDto {
  String facebookId;
  String facebookToken;
  String name;
  String email;
  FacebookUserDto({this.facebookId, this.facebookToken, this.name, this.email});
}

class TwitterUserDto {
  String twitterId;
  String twitterToken;
  String twitterSecretToken;
  String name;
  TwitterUserDto({this.twitterId, this.twitterToken, this.twitterSecretToken, this.name});
}

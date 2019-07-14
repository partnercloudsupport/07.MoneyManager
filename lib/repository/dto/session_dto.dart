import 'package:cloud_firestore/cloud_firestore.dart';

/// Created by Huan.Huynh on 2019-07-05.
///
/// Copyright © 2019 teqnological. All rights reserved.
class SessionDto {
  String id;
  String name;
  String email;
  String password;
  DateTime birthday;
  String address;
  DateTime createdDay;
  bool isNotify;
  String facebookId;
  String facebookToken;
  String twitterId;
  String twitterToken;
  String twitterSecretToken;

  SessionDto({
    this.id,
    this.name, this.email, this.password,
    this.birthday, this.address, this.createdDay, this.isNotify,
    this.facebookId, this.facebookToken,
    this.twitterId, this.twitterToken, this.twitterSecretToken});

  SessionDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    birthday = json['birthday'] != null
      ? DateTime.fromMicrosecondsSinceEpoch((json['birthday'] as Timestamp).microsecondsSinceEpoch) : null;
    address = json['address'];
    createdDay = json['createdDay'] != null
      ? DateTime.fromMicrosecondsSinceEpoch((json['createdDay'] as Timestamp).microsecondsSinceEpoch) : null;
    isNotify = json['isNotify'] as bool;
    facebookId = json['facebookId'];
    facebookToken = json['facebookToken'];
    twitterId = json['twitterId'];
    twitterToken = json['twitterToken'];
    twitterSecretToken = json['twitterSecretToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.name != null) {
      data['name'] = this.name;
    }

    if (this.email != null) {
      data['email'] = this.email;
    }

    if (this.password != null) {
      data['password'] = this.password;
    }

    if (this.birthday != null) {
      data['birthday'] = this.birthday;
    }

    if (this.address != null) {
      data['address'] = this.address;
    }

    if (this.createdDay != null) {
      data['createdDay'] = this.createdDay;
    }

    if (this.isNotify != null) {
      data['isNotify'] = this.isNotify;
    }

    if (this.facebookId != null) {
      data['facebookId'] = this.facebookId;
    }

    if (this.facebookToken != null) {
      data['facebookToken'] = this.facebookToken;
    }

    if (this.twitterId != null) {
      data['twitterId'] = this.twitterId;
    }

    if (this.twitterToken != null) {
      data['twitterToken'] = this.twitterToken;
    }

    if (this.twitterSecretToken != null) {
      data['twitterSecretToken'] = this.twitterSecretToken;
    }
    return data;
  }
}

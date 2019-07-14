import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

/// Created by Huan.Huynh on 2019-07-05.
///
/// Copyright © 2019 teqnological. All rights reserved.

@JsonSerializable(nullable: false)
class SessionDto {
  @JsonKey(name: "id") String id;
  @JsonKey(name: "name") String name;
  @JsonKey(name: "email") String email;
  @JsonKey(name: "password") String password;
  @JsonKey(name: "birthday") DateTime birthday;
  @JsonKey(name: "address") String address;
  @JsonKey(name: "createdDay") DateTime createdDay;
  @JsonKey(name: "isNotify") bool isNotify;
  @JsonKey(name: "facebookId") String facebookId;
  @JsonKey(name: "facebookToken") String facebookToken;
  @JsonKey(name: "twitterId") String twitterId;
  @JsonKey(name: "twitterToken") String twitterToken;
  @JsonKey(name: "twitterSecretToken") String twitterSecretToken;

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
    if(json['birthday'] != null) {
      if(json['birthday'] != null is String) {
        birthday = json['birthday'] != null
          ? DateTime.parse(json['birthday']) : null;
      } else if(json['birthday'] != null is Timestamp) {
        birthday = json['birthday'] != null
          ? DateTime.fromMicrosecondsSinceEpoch((json['birthday'] as Timestamp).microsecondsSinceEpoch) : null;
      }
    }
    address = json['address'];
    if(json['createdDay'] != null) {
      if(json['createdDay'] != null is String) {
        createdDay = json['createdDay'] != null
          ? DateTime.parse(json['createdDay']) : null;
      } else if(json['createdDay'] != null is Timestamp) {
        createdDay = json['createdDay'] != null
          ? DateTime.fromMicrosecondsSinceEpoch((json['createdDay'] as Timestamp).microsecondsSinceEpoch) : null;
      }
    }
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
      data['birthday'] = this.birthday.toString();
    }

    if (this.address != null) {
      data['address'] = this.address;
    }

    if (this.createdDay != null) {
      data['createdDay'] = this.createdDay.toString();
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

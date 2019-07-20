import 'package:json_annotation/json_annotation.dart';

/// Created by Huan.Huynh on 2019-07-19.
///
/// Copyright © 2019 teqnological. All rights reserved.

@JsonSerializable(nullable: false)
class AccountDto {
  @JsonKey(name: "id") String id;
  @JsonKey(name: "name") String name;
  @JsonKey(name: "initial_money") String initialMoney;
  @JsonKey(name: "current_money") String currentMoney;
  @JsonKey(name: "account_type") String accountType;
  @JsonKey(name: "country") String country;
  @JsonKey(name: "description") String description;
  @JsonKey(name: "is_report") bool isReport;
  @JsonKey(name: "user_id") String userId;
  @JsonKey(name: "is_enable") bool isEnable;

  AccountDto({
    this.id,
    this.name, this.initialMoney, this.currentMoney, this.accountType,
    this.country, this.description, this.isReport,
    this.userId, this.isEnable,
  });

  AccountDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    initialMoney = json['initial_money'];
    currentMoney = json['current_money'];
    accountType = json['account_type'];
    country = json['country'];
    description = json['description'];
    isReport = json['is_report'] as bool;
    userId = json['user_id'];
    isEnable = json['is_enable'] as bool;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.name != null) {
      data['name'] = this.name;
    }

    if (this.initialMoney != null) {
      data['initial_money'] = this.initialMoney;
    }

    if (this.currentMoney != null) {
      data['current_money'] = this.currentMoney;
    }

    if (this.accountType != null) {
      data['account_type'] = this.accountType;
    }

    if (this.country != null) {
      data['country'] = this.country.toString();
    }

    if (this.description != null) {
      data['description'] = this.description;
    }

    if (this.isReport != null) {
      data['is_report'] = this.isReport;
    }

    if (this.userId != null) {
      data['user_id'] = this.userId.toString();
    }

    if (this.isEnable != null) {
      data['is_enable'] = this.isEnable;
    }
    return data;
  }
}

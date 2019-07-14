import 'dart:convert';

import 'package:money_manager/repository/dto/session_dto.dart';
import 'package:prefs/prefs.dart';

/// Created by Huan.Huynh on 2019-07-14.
///
/// Copyright © 2019 teqnological. All rights reserved.

saveSession(SessionDto session) {
  if (session != null) {
    Prefs.setString("session", json.encode(session));
  } else {
    Prefs.remove("session");
  }
}

SessionDto getSession() {
  var sessionStr = Prefs.getString("session");
  if (sessionStr == null || sessionStr.isEmpty) return null;
  var sessionMap = json.decode(sessionStr);
  return SessionDto.fromJson(sessionMap);
}

bool isLogin() => Prefs.getString("session") != null && Prefs.getString("session").isNotEmpty;

String loggedId() => getSession().id;

/// Created by Huan.Huynh on 2019-07-05.
///
/// Copyright © 2019 teqnological. All rights reserved.
class NetworkException implements Exception {
  final String message;

  @pragma("vm:entry-point")
  NetworkException([this.message = ""]);

  @override
  String toString() => message;
}

class UnAuthorizedException implements NetworkException {
  final String message;

  @pragma("vm:entry-point")
  UnAuthorizedException([this.message = ""]);

  @override
  String toString() => message;
}
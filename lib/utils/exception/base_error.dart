import 'package:flutter/foundation.dart';

import 'base_exception.dart';

class BaseError implements Exception {
  final String? errMsgToastToUser;
  final Exception? exception;
  BaseError(this.errMsgToastToUser, [this.exception]);
  factory BaseError.fromObjectErr(Object? e) {
    if (e is BaseException) {
      return BaseError(e.message, e);
    } else if (e is BaseError) {
      return e;
    } 
    if (kDebugMode) {
      return BaseError(
        e.toString(),
      );
    } else {
      return BaseError(
        'Có lỗi xảy ra, vui lòng thử lại sau',
      );
    }
  }
}

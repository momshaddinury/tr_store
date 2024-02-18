import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_network/flutter_network.dart';
import 'package:tr_store/src/core/network/error_model.dart';

extension FutureResponseExtension on Future<Response> {
  Future<Either<ErrorModel, T>> guard<T>(Function(dynamic) parse) async {
    try {
      final response = await this;

      return Right(parse(response.data));
    } on Failure catch (e, stacktrace) {
      log(
        runtimeType.toString(),
        error: {},
        stackTrace: stacktrace,
      );
      ErrorModel errorModel = ErrorModel.fromJson(e.error);

      return Left(errorModel);
    }
  }
}

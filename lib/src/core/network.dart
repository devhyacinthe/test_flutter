import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_user/src/configurations/constants.dart';
import 'package:random_user/src/utils/config.dart';
import 'core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

final networkRepositoryProvider = StateProvider((ref) {
  return NetworkRepository();
});

/// Contains common methods required for client side APIs [GET, POST, PUT, DELETE].
/// Pass the [url] from endpoints using [Endpoints] class.
class NetworkRepository {
  NetworkRepository();

  FutureEither<Response> getRequest({required String url}) async {
    final Map<String, String> requestHeaders = {
      "Content-Type": "application/json"
    };
    if (AppConfig.logHttp) {
      log('REQUEST TO : $url', name: LogLabel.httpGet);
    }
    try {
      final response = await get(Uri.parse(url), headers: requestHeaders);
      log('RESPONSE : ${response.body}', name: LogLabel.httpGet);
      return Right(response);
    } catch (e, stktrc) {
      return Left(Failure(
          message: NetworkFailureMessage.getRequestMessage,
          stackTrace: stktrc));
    }
  }

  FutureEither<Response> postRequest(
      {required String url, dynamic body}) async {
    final Map<String, String> requestHeaders = {
      "Content-Type": "application/json"
    };

    if (AppConfig.logHttp) {
      log('REQUEST TO : $url', name: LogLabel.httpPost);
      log('BODY : $body', name: LogLabel.httpPost);
    }
    try {
      final response = await post(Uri.parse(url),
          body: jsonEncode(body), headers: requestHeaders);
      log('RESPONSE : ${response.body}', name: LogLabel.httpPost);
      return Right(response);
    } catch (e, stktrc) {
      return Left(Failure(
          message: NetworkFailureMessage.postRequestMessage,
          stackTrace: stktrc));
    }
  }

  FutureEither<Response> putRequest({required String url, dynamic body}) async {
    final Map<String, String> requestHeaders = {
      "Content-Type": "application/json"
    };

    if (AppConfig.logHttp) {
      log('REQUEST TO : $url', name: LogLabel.httpPut);

      log('BODY : $body', name: LogLabel.httpPut);
    }
    try {
      final response = await put(Uri.parse(url),
          body: jsonEncode(body), headers: requestHeaders);
      log('RESPONSE : ${response.body}', name: LogLabel.httpPut);
      return Right(response);
    } catch (e, stktrc) {
      return Left(Failure(
          message: NetworkFailureMessage.putRequestMessage,
          stackTrace: stktrc));
    }
  }

  FutureEither<Response> deleteRequest(
      {required String url, dynamic body}) async {
    final Map<String, String> requestHeaders = {
      "Content-Type": "application/json"
    };

    if (AppConfig.logHttp) {
      log('REQUEST TO : $url', name: LogLabel.httpDelete);
      log('BODY : $body', name: LogLabel.httpDelete);
    }
    try {
      final response = await delete(Uri.parse(url),
          body: jsonEncode(body), headers: requestHeaders);
      log('RESPONSE : ${response.body}', name: LogLabel.httpDelete);
      return Right(response);
    } catch (e, stktrc) {
      return Left(Failure(
          message: NetworkFailureMessage.deleteRequestMessage,
          stackTrace: stktrc));
    }
  }
}

import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';
import 'package:random_user/src/core/core.dart';
import 'package:random_user/src/features/users/configurations/endpoints.dart';
import 'package:random_user/src/features/users/configurations/message.dart';
import 'package:random_user/src/models/user.dart';

final usersRepositoryProvider = Provider((ref) {
  final api = ref.watch(networkRepositoryProvider);
  return UsersRepository(api: api);
});

class UsersRepository {
  final NetworkRepository _api;
  final _name = "USERS_CONTROLLER";

  UsersRepository({required NetworkRepository api}) : _api = api;

  FutureEither<List<User>> loadUsers() async {
    final result = await _api.getRequest(url: EndPoints.getUsers);

    return result.fold((Failure failure) {
      log(failure.message, name: _name);
      return Left(failure);
    }, (Response response) {
      try {
        if (response.statusCode >= 400 || response.statusCode == 204) {
          List<User> userNull = [];

          return Right(userNull);
        }

        final data = jsonDecode(response.body);

        List<User> userResponse = [];

        List users = data['results'];

        for (var user in users) {
          userResponse.add(User.fromMap(user));
        }

        return Right(userResponse);
      } catch (e, stktrc) {
        log(FailureMessage.jsonParseFailed, name: _name);
        return Left(Failure(
          message: FailureMessage.jsonParseFailed,
          stackTrace: stktrc,
        ));
      }
    });
  }

  FutureEither<String> loadImage(String gender) async {
    final result = await _api.getRequest(url: "${EndPoints.getImage}$gender");

    return result.fold((Failure failure) {
      log(failure.message, name: _name);
      return Left(failure);
    }, (Response response) {
      try {
        if (response.statusCode >= 400 || response.statusCode == 204) {
          String userNull = "";

          return Right(userNull);
        }

        final data = jsonDecode(response.body);

        String image = data['results'][0]['picture']['large'];

        return Right(image);
      } catch (e, stktrc) {
        log(FailureMessage.jsonParseFailed, name: _name);
        return Left(Failure(
          message: FailureMessage.jsonParseFailed,
          stackTrace: stktrc,
        ));
      }
    });
  }
}

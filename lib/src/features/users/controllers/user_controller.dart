import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:random_user/src/configurations/constants.dart';
import 'package:random_user/src/configurations/database/database_service.dart';
import 'package:random_user/src/features/users/configurations/message.dart';
import 'package:random_user/src/features/users/repositories/user_repository.dart';
import 'package:random_user/src/models/user.dart';
import 'package:random_user/src/utils/snackbar.dart';

final usersControllerProvider = Provider((ref) {
  final repository = ref.watch(usersRepositoryProvider);

  return UsersController(repository: repository);
});

class UsersController {
  final UsersRepository _repository;

  UsersController({required UsersRepository repository})
      : _repository = repository;

  Future<void> loadUsers({BuildContext? context}) async {
    final result = await _repository.loadUsers();
    return result.fold((failure) {
      if (context != null) {
        SnackBarService.showSnackBar(
            duration: const Duration(seconds: 2),
            context: context,
            message: FailureMessage.loadUsers,
            backgroundColor: Colors.redAccent);
      }
    }, (users) async {
      if (context != null) {
        for (var user in users) {
          await DatabaseService.insertUser(user.toMap());
        }
      }
    });
  }

  Future<String> loadImage({BuildContext? context, String? gender}) async {
    final result = await _repository.loadImage(gender!);
    return result.fold((failure) {
      if (context != null) {
        SnackBarService.showSnackBar(
            duration: const Duration(seconds: 2),
            context: context,
            message: FailureMessage.loadUsers,
            backgroundColor: Colors.redAccent);
      }
      return "";
    }, (picture) {
      if (context != null) {
        return picture;
      }
      return picture;
    });
  }

  Future<List<User>> getAllUsers({BuildContext? context}) async {
    final data = await DatabaseService.getAllUsers();
    List<User> users = [];

    for (var user in data) {
      users.add(User.fromMapDatabase(user));
    }

    if (context != null) {
      return users;
    }
    return users;
  }

  Future<void> createUser({BuildContext? context, User? user}) async {
    try {
      await DatabaseService.insertUser(user!.toMap());
      if (context != null) {
        // ignore: use_build_context_synchronously
        SnackBarService.showSnackBar(
            duration: const Duration(seconds: 2),
            context: context,
            message: SuccessMessage.addUser,
            backgroundColor: Colors.greenAccent);
        // ignore: use_build_context_synchronously
        context.pushNamed(AppRouteName.home);
      }
    } catch (error) {
      if (context != null) {
        // ignore: use_build_context_synchronously
        SnackBarService.showSnackBar(
            duration: const Duration(seconds: 2),
            context: context,
            message: FailureMessage.addUser,
            backgroundColor: Colors.redAccent);
        // ignore: use_build_context_synchronously
        context.pop();
      }
    }
  }

  Future<void> updateUser(
      {BuildContext? context, String? uuid, User? user}) async {
    try {
      await DatabaseService.updateUser(uuid!, user!.toMap());

      if (context != null) {
        // ignore: use_build_context_synchronously
        SnackBarService.showSnackBar(
            duration: const Duration(seconds: 2),
            context: context,
            message: SuccessMessage.updateUser,
            backgroundColor: Colors.greenAccent);
        // ignore: use_build_context_synchronously
        context.pop();
      }
    } catch (error) {
      if (context != null) {
        // ignore: use_build_context_synchronously
        SnackBarService.showSnackBar(
            duration: const Duration(seconds: 2),
            context: context,
            message: FailureMessage.updateUser,
            backgroundColor: Colors.redAccent);
        // ignore: use_build_context_synchronously
        context.pop();
      }
    }
  }

  Future<void> deleteUser({BuildContext? context, String? uuid}) async {
    try {
      await DatabaseService.deleteUser(uuid!);

      if (context != null) {
        // ignore: use_build_context_synchronously
        SnackBarService.showSnackBar(
            duration: const Duration(seconds: 2),
            context: context,
            message: SuccessMessage.deleteUser,
            backgroundColor: Colors.greenAccent);
      }
    } catch (error) {
      if (context != null) {
        // ignore: use_build_context_synchronously
        SnackBarService.showSnackBar(
            duration: const Duration(seconds: 2),
            context: context,
            message: FailureMessage.deleteUser,
            backgroundColor: Colors.redAccent);
        // ignore: use_build_context_synchronously
        context.pop();
      }
    }
  }
}

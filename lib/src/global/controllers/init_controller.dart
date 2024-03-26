import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_user/src/core/core.dart';
import 'package:random_user/src/global/controllers/shared_prefs_controller.dart';
import 'package:random_user/src/global/providers/user_list_provider.dart';

final initControllerProvider = Provider((ref) => InitController(ref: ref));

class InitController {
  final Ref _ref;

  InitController({required Ref ref}) : _ref = ref;

  FutureVoid loadDatabaseToken() async {
    await _ref
        .read(sharedPrefsControllerPovider)
        .getLoadDatabaseToken()
        .then((value) {
      _ref.read(loadDatabaseProvider.notifier).update((state) => value);
    });
  }

  FutureVoid initLoadDatabaseToken(String token) async {
    await _ref
        .read(sharedPrefsControllerPovider)
        .setLoadDatabaseToken(token: token);
  }

  FutureVoid getDarkMode() async {
    await _ref.read(sharedPrefsControllerPovider).getDarkMode().then((value) {
      _ref.read(darkModeProvider.notifier).update((state) => value);
    });
  }

  FutureVoid setDarkMode(String token) async {
    await _ref.read(sharedPrefsControllerPovider).setDarkMode(token: token);
  }

  FutureVoid clearLoadDatabaseToken() async {
    await _ref.read(sharedPrefsControllerPovider).clear();
  }
}

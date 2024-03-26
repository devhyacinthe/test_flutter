import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_user/src/core/core.dart';
import 'package:random_user/src/global/repositories/shared_prefs_reposirory.dart';

final sharedPrefsControllerPovider = Provider((ref) {
  final repository = ref.watch(sharedPrefsRepositoryProvider);
  return SharedPrefsController(repository: repository);
});

class SharedPrefsController {
  final SharedPrefsRepository _repo;

  SharedPrefsController({required SharedPrefsRepository repository})
      : _repo = repository;

  Future<String?> getLoadDatabaseToken() async {
    return _repo.getLoadDatabaseToken();
  }

  FutureVoid setLoadDatabaseToken({required String token}) async {
    await _repo.setLoadDatabaseToken(token);
  }

  Future<String?> getDarkMode() async {
    return _repo.getDarkMode();
  }

  FutureVoid setDarkMode({required String token}) async {
    await _repo.setDarkMode(token);
  }

  FutureVoid clear() async {
    return _repo.clear();
  }
}

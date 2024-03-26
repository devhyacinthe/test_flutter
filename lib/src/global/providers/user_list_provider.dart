import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_user/src/models/user.dart';

final usersListProvider = StateProvider<List<User>>((ref) => []);
final loadDatabaseProvider = StateProvider<String?>((ref) => null);
final darkModeProvider = StateProvider<String?>((ref) => null);

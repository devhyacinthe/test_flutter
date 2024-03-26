import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_user/src/models/user.dart';

final usersListProvider = StateProvider<List<User>>((ref) => []);
final loadDatabaseProvider = StateProvider<String?>((ref) => null);
final darkModeProvider = StateProvider<String?>((ref) => null);

//user property state
final userFirstNameProvider = StateProvider<String>((ref) => "");
final userLastNameProvider = StateProvider<String>((ref) => "");
final userEmailProvider = StateProvider<String>((ref) => "");
final userCityProvider = StateProvider<String>((ref) => "");
final userStreetProvider = StateProvider<String>((ref) => "");

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_user/src/models/user.dart';

final searchUserListProvider = StateProvider<List<User>>((ref) => []);

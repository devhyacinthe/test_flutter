import 'package:random_user/src/configurations/assets/base.dart';

class EndPoints {
  static const _base = BasePaths.baseUrl;

  static const String getUsers = '$_base/?results=20';
  static const String getImage = '$_base/?gender=';
}

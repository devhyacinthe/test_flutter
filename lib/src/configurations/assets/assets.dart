import 'package:random_user/src/configurations/assets/base.dart';

/// Contains all the paths of image used across the project.
/// Every image path variable name must contain a name and its extension.
/// example :
///
/// for an image with name avatar.png,
/// a suitable variable can be [avatarImagePng].
/// ```dart
/// static const sampleImagePng = "$_base/image.png";
/// ```
/// can be used by doing
/// ```dart
/// ImageAssets.sampleImagePng
/// ```
class ImageAssets {
  const ImageAssets._();

  static const _base = BasePaths.baseImagePath;

  static const String onBoarding = "$_base/onboarding.png";
  static const String appLogo = "$_base/app_logo.png";
  static const String appLogoDark = "$_base/app_logo_dark.png";
  static const String placeholder = "$_base/placeholder.png";
}

class AnimationAssets {
  const AnimationAssets._();

  /// Contains all the paths of animations used across the project.
  //static const _base = BasePaths.baseImagePath;

  //static const sampleAnimationPath = "$_base/animation.png";
}

class IconAssets {
  const IconAssets._();

  /// Contains all the paths of icons used across the project.
  static const _base = BasePaths.baseIconPath;

  static const String arrow_left = "$_base/arrow-left.svg";
  static const String password = "$_base/key-square.svg";
  static const String phoneNumber = "$_base/smartphone.svg";
  static const String arrow_right = "$_base/arrow-right.svg";
  static const String user = "$_base/user.svg";
  static const String edit = "$_base/edit.svg";
  static const String share = "$_base/share-2.svg";
  static const String contact = "$_base/message-circle-more.svg";
  static const String info = "$_base/info.svg";
  static const String client = "$_base/contact-2.svg";
  static const String trash = "$_base/trash.svg";
  static const String settings = "$_base/settings.svg";
  static const String mail = "$_base/mail.svg";
  static const String cart = "$_base/shopping-cart.svg";
  static const String add = "$_base/add.svg";
  static const String sun = "$_base/sun.svg";
  static const String moon = "$_base/moon.svg";
  static const String search = "$_base/search.svg";
  static const String alert = "$_base/alert-danger.svg";
  static const String map = "$_base/map-pin.svg";
  static const String filter = "$_base/filter.svg";
}

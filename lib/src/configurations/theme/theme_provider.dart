import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_user/src/configurations/theme/theme.dart';

final themeProvider = StateProvider<ThemeData>((ref) => lightMode);

import 'package:flutter/material.dart';
import 'package:random_user/src/configurations/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_user/src/configurations/theme/theme_provider.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp.router(
      title: 'Random User',
      theme: theme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

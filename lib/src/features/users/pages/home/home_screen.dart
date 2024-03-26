import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:random_user/src/configurations/assets/assets.dart';
import 'package:random_user/src/configurations/constants.dart';
import 'package:random_user/src/configurations/theme/theme.dart';
import 'package:random_user/src/configurations/theme/theme_provider.dart';
import 'package:random_user/src/features/users/controllers/user_controller.dart';
import 'package:random_user/src/features/users/widgets/user_card.dart';
import 'package:random_user/src/global/controllers/init_controller.dart';
import 'package:random_user/src/global/providers/user_list_provider.dart';
import 'package:random_user/src/models/user.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isDarkMode = false;

  List<User> dataList = [];

  void _getAllUsers() async {
    var usersList =
        await ref.read(usersControllerProvider).getAllUsers(context: context);
    setState(() {
      dataList = usersList;
    });
    ref.read(usersListProvider.notifier).state.addAll(usersList);
  }

  _checkIfDatabaseIsLoaded() {
    ref.read(initControllerProvider).loadDatabaseToken().then(
      (value) {
        final token = ref.read(loadDatabaseProvider);
        if (token == null) {
          ref.read(usersControllerProvider).loadUsers(context: context);
          ref.read(initControllerProvider).initLoadDatabaseToken("load");
          _getAllUsers();
        }
      },
    );
  }

  void _toggleTheme(ThemeData themeData) {
    if (themeData == lightMode) {
      ref.read(themeProvider.notifier).state = darkMode;
      ref.read(initControllerProvider).setDarkMode("dark");
      setState(() {
        isDarkMode = true;
      });
    } else {
      ref.read(themeProvider.notifier).state = lightMode;
      ref.read(initControllerProvider).setDarkMode("light");
      setState(() {
        isDarkMode = false;
      });
    }
  }

  _initTheme() {
    ref.read(initControllerProvider).getDarkMode().then((value) {
      final darkModeToken = ref.read(darkModeProvider);

      if (darkModeToken == null) {
        ref.read(initControllerProvider).setDarkMode("light");
        ref.read(themeProvider.notifier).state = lightMode;
        setState(() {
          isDarkMode = false;
        });
      }

      if (darkModeToken == "light") {
        ref.read(themeProvider.notifier).state = lightMode;
        ref.read(initControllerProvider).setDarkMode("light");
        setState(() {
          isDarkMode = false;
        });
      } else {
        ref.read(themeProvider.notifier).state = darkMode;
        ref.read(initControllerProvider).setDarkMode("dark");
        setState(() {
          isDarkMode = true;
        });
      }
    });
  }

  @override
  void initState() {
    _checkIfDatabaseIsLoaded();
    _getAllUsers();
    _initTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final usersListState = ref.watch(usersListProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: _buildAppBar(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 20,
        onPressed: () {
          context.pushNamed(AppRouteName.addUser);
        },
        child: SvgPicture.asset(
          IconAssets.add,
          color: Theme.of(context).colorScheme.secondary,
          width: 25,
          height: 25,
        ),
      ),
      body: ListView.builder(
          itemCount: usersListState.length,
          itemBuilder: (context, index) {
            return Dismissible(
              background: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 15.0),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: SvgPicture.asset(
                      IconAssets.trash,
                      color: Theme.of(context).colorScheme.secondary,
                      width: 35,
                      height: 35,
                    ),
                  )),
              key: Key(UniqueKey().toString()),
              onDismissed: (direction) {
                ref
                    .read(usersControllerProvider)
                    .deleteUser(context: context, uuid: dataList[index].uuid);
                setState(() {
                  dataList.remove(dataList[index]);
                });
                ref.read(usersListProvider.notifier).state.removeAt(index);
              },
              child: UserCard(user: usersListState[index]),
            );
          }),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      leading: isDarkMode
          ? Image.asset(
              ImageAssets.appLogoDark,
              fit: BoxFit.contain,
            )
          : Image.asset(
              ImageAssets.appLogo,
              fit: BoxFit.contain,
            ),
      actions: [
        IconButton(
            onPressed: () => context.pushNamed(AppRouteName.search),
            icon: SvgPicture.asset(
              IconAssets.search,
              color: Theme.of(context).colorScheme.secondary,
              width: 20,
              height: 25,
            )),
        IconButton(
          onPressed: () {
            _toggleTheme(ref.watch(themeProvider));
          },
          icon: isDarkMode
              ? SvgPicture.asset(
                  IconAssets.sun,
                  color: Theme.of(context).colorScheme.secondary,
                  width: 25,
                  height: 25,
                )
              : SvgPicture.asset(
                  IconAssets.moon,
                  color: Theme.of(context).colorScheme.secondary,
                  width: 25,
                  height: 25,
                ),
        )
      ],
    );
  }
}

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:random_user/src/configurations/constants.dart';
import 'package:random_user/src/features/search_user/pages/search_screen.dart';
import 'package:random_user/src/features/users/pages/add_users/add_user_screen.dart';
import 'package:random_user/src/features/users/pages/home/home_screen.dart';

GoRouter router = GoRouter(routes: [
  GoRoute(
    name: AppRouteName.home,
    path: '/',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        transitionDuration: const Duration(milliseconds: 340),
        reverseTransitionDuration: const Duration(milliseconds: 340),
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                .animate(animation),
            child: child,
          );
        },
        child: const HomeScreen(),
      );
    },
  ),
  GoRoute(
    name: AppRouteName.addUser,
    path: '/add',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        transitionDuration: const Duration(milliseconds: 340),
        reverseTransitionDuration: const Duration(milliseconds: 340),
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                .animate(animation),
            child: child,
          );
        },
        child: const AddUserScreen(),
      );
    },
  ),
  GoRoute(
    name: AppRouteName.search,
    path: '/search',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        transitionDuration: const Duration(milliseconds: 340),
        reverseTransitionDuration: const Duration(milliseconds: 340),
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                .animate(animation),
            child: child,
          );
        },
        child: const SearchScreen(),
      );
    },
  ),
]);

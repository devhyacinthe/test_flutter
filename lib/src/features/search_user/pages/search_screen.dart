import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:random_user/src/configurations/assets/assets.dart';
import 'package:random_user/src/features/search_user/providers/search_list_provider.dart';
import 'package:random_user/src/features/search_user/widgets/filter_bottom_sheet.dart';
import 'package:random_user/src/features/search_user/widgets/search_textfield.dart';
import 'package:random_user/src/features/search_user/widgets/user_search_card.dart';
import 'package:random_user/src/features/users/controllers/user_controller.dart';
import 'package:random_user/src/models/user.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String query = '';
  List<User> searchList = [];

  _fetchUsers() async {
    var usersList =
        await ref.read(usersControllerProvider).getAllUsers(context: context);
    setState(() {
      searchList = usersList;
    });
  }

  _filter(String query) {
    if (query == '') {
      ref.read(searchUserListProvider.notifier).state = [];
    } else {
      _fetchUsers();
      var filter = searchList
          .where((item) => item.firstName!
              .toLowerCase()
              .toString()
              .toLowerCase()
              .contains(query.trim().trim().toLowerCase().toString()))
          .toList();
      ref.read(searchUserListProvider.notifier).state = filter;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUsers();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchUserListState = ref.watch(searchUserListProvider);

    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        ref.read(searchUserListProvider.notifier).state = [];
                        context.pop();
                      },
                      icon: SvgPicture.asset(
                        IconAssets.arrow_left,
                        color: Theme.of(context).colorScheme.primary,
                        width: 25,
                        height: 25,
                      ),
                    ),
                    Expanded(
                        child: CustomSearchTextFormField(
                      hint: 'Rechercher',
                      prefixIcon: Icons.search_rounded,
                      controller: _searchController,
                      suffixIcon: _searchController.text.isEmpty
                          ? null
                          : Icons.cancel_sharp,
                      onTapSuffixIcon: () {
                        _searchController.clear();
                        ref.read(searchUserListProvider.notifier).state = [];
                      },
                      filled: true,
                      onEditingComplete: () {
                        setState(() {
                          query = _searchController.text.trim();
                        });
                        _filter(query);
                      },
                      onChanged: (pure) {
                        setState(() {});
                      },
                    )),
                    IconButton(
                      onPressed: () {
                        ref.read(searchUserListProvider.notifier).state = [];
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25))),
                            builder: (context) => const FilterBottomSheet());
                      },
                      icon: SvgPicture.asset(
                        IconAssets.filter,
                        color: Theme.of(context).colorScheme.primary,
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: searchUserListState.isEmpty
                        ? LottieBuilder.asset(AnimationAssets.search)
                        : ListView.builder(
                            itemCount: searchUserListState.length,
                            itemBuilder: (context, index) => UserSearchCard(
                                user: searchUserListState[index])),
                  )),
            ]),
          )),
    );
  }
}

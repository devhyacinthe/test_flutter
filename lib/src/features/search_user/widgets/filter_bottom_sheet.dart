import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:random_user/src/configurations/assets/assets.dart';
import 'package:random_user/src/features/search_user/providers/search_list_provider.dart';
import 'package:random_user/src/features/users/controllers/user_controller.dart';
import 'package:random_user/src/features/users/widgets/primary_button.dart';
import 'package:random_user/src/models/user.dart';

class FilterBottomSheet extends ConsumerStatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  ConsumerState<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends ConsumerState<FilterBottomSheet> {
  String filterValue = "AZ";

  /// filter boolean variable
  bool isMaleTaped = false;
  bool isFemaleTaped = false;
  bool isAzTaped = true;
  bool isZaTaped = false;

  List<User> searchList = [];

  _filter(String filterValue) {
    switch (filterValue) {
      case "male":
        var filter = ref
            .read(searchUserListProvider.notifier)
            .state
            .where((element) => element.gender == 'male')
            .toList();
        ref.read(searchUserListProvider.notifier).state = filter;
        break;
      case "female":
        var filter = ref
            .read(searchUserListProvider.notifier)
            .state
            .where((element) => element.gender == 'female')
            .toList();
        ref.read(searchUserListProvider.notifier).state = filter;
        break;
      case "AZ":
        searchList.sort((a, b) => a.firstName!
            .toLowerCase()
            .toString()
            .compareTo(b.firstName!.toLowerCase().toString()));
        ref.read(searchUserListProvider.notifier).state = searchList;
        break;
      case "ZA":
        searchList.sort((b, a) => a.firstName!
            .toLowerCase()
            .toString()
            .compareTo(b.firstName!.toLowerCase().toString()));
        ref.read(searchUserListProvider.notifier).state = searchList;
        break;
      default:
    }
  }

  _fetchUsers() async {
    var usersList =
        await ref.read(usersControllerProvider).getAllUsers(context: context);
    setState(() {
      searchList = usersList;
    });
    ref.read(searchUserListProvider.notifier).state.addAll(usersList);
  }

  _selectFilterLogic() {
    switch (filterValue) {
      case "AZ":
        setState(() {
          isAzTaped = true;
          isFemaleTaped = false;
          isMaleTaped = false;
          isZaTaped = false;
        });
        break;
      case "ZA":
        setState(() {
          isAzTaped = false;
          isFemaleTaped = false;
          isMaleTaped = false;
          isZaTaped = true;
        });
        break;
      case "male":
        setState(() {
          isAzTaped = false;
          isFemaleTaped = false;
          isMaleTaped = true;
          isZaTaped = false;
        });
        break;
      case "female":
        setState(() {
          isAzTaped = false;
          isFemaleTaped = true;
          isMaleTaped = false;
          isZaTaped = false;
        });
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    _selectFilterLogic();
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 22,
                      child: IconButton(
                        icon: const Icon(CupertinoIcons.clear),
                        onPressed: () => context.pop(),
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Trier par",
                      style: Theme.of(context).textTheme.bodyLarge)
                ],
              ),
              _buildDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.male, size: 30),
                  Text("Homme", style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(
                    width: 200,
                  ),
                  IconButton(
                      icon: isMaleTaped
                          ? const Icon(Icons.check,
                              color: Colors.blueAccent, size: 30)
                          : const Icon(Icons.check, size: 30),
                      onPressed: () {
                        setState(() {
                          filterValue = 'male';
                          _selectFilterLogic();
                        });
                      })
                ],
              ),
              _buildDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.female, size: 30),
                  Text("Femme", style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(
                    width: 200,
                  ),
                  IconButton(
                      icon: isFemaleTaped
                          ? const Icon(Icons.check,
                              color: Colors.blueAccent, size: 30)
                          : const Icon(Icons.check, size: 30),
                      onPressed: () {
                        setState(() {
                          filterValue = 'female';
                          _selectFilterLogic();
                        });
                      })
                ],
              ),
              _buildDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    IconAssets.filterAZ,
                    color: Theme.of(context).colorScheme.primary,
                    width: 25,
                    height: 25,
                  ),
                  Text("a-Z", style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(
                    width: 200,
                  ),
                  IconButton(
                      icon: isAzTaped
                          ? const Icon(Icons.check,
                              color: Colors.blueAccent, size: 30)
                          : const Icon(Icons.check, size: 30),
                      onPressed: () {
                        setState(() {
                          filterValue = 'AZ';
                          _selectFilterLogic();
                        });
                      })
                ],
              ),
              _buildDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    IconAssets.filterZA,
                    color: Theme.of(context).colorScheme.primary,
                    width: 25,
                    height: 25,
                  ),
                  Text("Z-a", style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(
                    width: 200,
                  ),
                  IconButton(
                      icon: isZaTaped
                          ? const Icon(Icons.check,
                              color: Colors.blueAccent, size: 30)
                          : const Icon(Icons.check, size: 30),
                      onPressed: () {
                        setState(() {
                          filterValue = 'ZA';
                          _selectFilterLogic();
                        });
                      })
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                  text: "Valider",
                  onPressed: () {
                    _filter(filterValue);

                    context.pop();
                  })
            ]),
      ),
    );
  }

  _buildDivider() {
    return Divider(
      color: Theme.of(context).colorScheme.primary,
      thickness: .1,
    );
  }
}

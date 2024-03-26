import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:random_user/src/configurations/assets/assets.dart';

import 'package:random_user/src/features/users/widgets/custom_textform_field.dart';
import 'package:random_user/src/models/user.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  User user = User.empty();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      IconAssets.arrow_left,
                      color: Theme.of(context).colorScheme.primary,
                      width: 25,
                      height: 25,
                    ),
                  ),
                  Expanded(
                      // changer ce textfield
                      child: CustomTextField(
                          suffixIcon: _controller.text == ""
                              ? null
                              : const Icon(Icons.cancel_sharp),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Veuillez saisir quelque chose";
                            }

                            return null;
                          },
                          controller: _controller,
                          keyboardType: TextInputType.text,
                          isObscureText: false,
                          hintText: 'Rechercher')),
                  IconButton(
                    onPressed: () {},
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
          )
        ]),
      )),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Rechercher",
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.w600)),
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset(
            IconAssets.filter,
            color: Theme.of(context).colorScheme.primary,
            width: 25,
            height: 25,
          ),
        ));
  }
}

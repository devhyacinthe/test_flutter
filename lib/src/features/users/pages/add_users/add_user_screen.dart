import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:random_user/src/configurations/constants.dart';
import 'package:random_user/src/features/users/widgets/custom_textform_field.dart';
import 'package:random_user/src/features/users/widgets/primary_button.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:random_user/src/configurations/assets/assets.dart';
import 'package:random_user/src/features/users/controllers/user_controller.dart';
import 'package:random_user/src/global/providers/user_list_provider.dart';
import 'package:random_user/src/models/user.dart';

class AddUserScreen extends ConsumerStatefulWidget {
  const AddUserScreen({super.key});

  @override
  ConsumerState<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends ConsumerState<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> genderChoiceList = ['male', 'female'];
  bool isLoading = false;
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  _createUser(User user) {
    ref.read(usersControllerProvider).createUser(context: context, user: user);
    ref.read(usersListProvider.notifier).state.add(user);
    _updateUserState();
  }

  void _updateUserState() async {
    var usersList =
        await ref.read(usersControllerProvider).getAllUsers(context: context);

    ref.read(usersListProvider.notifier).state = usersList;
  }

  _loadUserImage(String gender) {
    return ref
        .read(usersControllerProvider)
        .loadImage(context: context, gender: gender);
  }

  _generateGender(List list) {
    final random = Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppText.nameTextFieldLabel,
                            style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: CustomTextField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Veuillez saisir votre nom";
                                      }
                                      if (value.length >= 30) {
                                        return "Veuillez saisir un  d'au plus 30 caractères";
                                      }
                                      return null;
                                    },
                                    controller: _lastNameController,
                                    keyboardType: TextInputType.text,
                                    isObscureText: false,
                                    hintText: "Nom")),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                flex: 1,
                                child: CustomTextField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Veuillez saisir votre prénom";
                                      }
                                      if (value.length >= 25) {
                                        return "Veuillez saisir un  d'au plus 25 caractères";
                                      }
                                      return null;
                                    },
                                    controller: _firstNameController,
                                    keyboardType: TextInputType.text,
                                    isObscureText: false,
                                    hintText: "Prénom(s)")),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppText.emailTextFieldLabel,
                            style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez saisir votre mail";
                              }
                              if (value.length >= 40) {
                                return "Veuillez saisir un  d'au plus 40 caractères";
                              }
                              return null;
                            },
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            isObscureText: false,
                            hintText: "Email"),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppText.streetTextFieldLabel,
                            style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez saisir le nom de la rue";
                              }
                              if (value.length >= 40) {
                                return "Veuillez saisir un  d'au plus 40 caractères";
                              }
                              return null;
                            },
                            controller: _streetController,
                            keyboardType: TextInputType.streetAddress,
                            isObscureText: false,
                            hintText: "Rue"),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppText.cityTextFieldLabel,
                            style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez saisir le nom de la ville";
                              }
                              if (value.length >= 40) {
                                return "Veuillez saisir un  d'au plus 40 caractères";
                              }
                              return null;
                            },
                            controller: _cityController,
                            keyboardType: TextInputType.text,
                            isObscureText: false,
                            hintText: "Ville"),
                      ],
                    ),
                    const SizedBox(height: 40),
                    isLoading
                        ? SpinKitChasingDots()
                        : PrimaryButton(
                            text: "Enregistrer",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                String gender =
                                    _generateGender(genderChoiceList);
                                String picture = await _loadUserImage(gender);

                                User updatedUser = User(
                                    uuid: const Uuid().toString(),
                                    firstName: _firstNameController.text.trim(),
                                    lastName: _lastNameController.text.trim(),
                                    gender: gender,
                                    email: _emailController.text.trim(),
                                    street: _streetController.text.trim(),
                                    city: _cityController.text.trim(),
                                    picture: picture);

                                _createUser(updatedUser);

                                setState(() {
                                  isLoading = false;
                                });
                              }
                            })
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Ajouter un utilisateur",
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
            IconAssets.arrow_left,
            color: Theme.of(context).colorScheme.primary,
            width: 25,
            height: 25,
          ),
        ));
  }
}

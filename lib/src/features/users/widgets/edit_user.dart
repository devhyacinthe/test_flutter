import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:random_user/src/features/users/controllers/user_controller.dart';
import 'package:random_user/src/features/users/widgets/custom_textform_field.dart';
import 'package:random_user/src/features/users/widgets/primary_button.dart';
import 'package:random_user/src/global/providers/user_list_provider.dart';
import 'package:random_user/src/models/user.dart';

class EditUserBottomSheet extends ConsumerStatefulWidget {
  final User? user;
  const EditUserBottomSheet({super.key, required this.user});

  @override
  ConsumerState<EditUserBottomSheet> createState() =>
      _EditUserBottomSheetState();
}

class _EditUserBottomSheetState extends ConsumerState<EditUserBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  _updateUser(String uuid, User user) {
    ref
        .read(usersControllerProvider)
        .updateUser(context: context, uuid: uuid, user: user);
    _updateUserState();
  }

  void _updateUserState() async {
    var usersList =
        await ref.read(usersControllerProvider).getAllUsers(context: context);

    ref.read(usersListProvider.notifier).state = usersList;
  }

  @override
  void initState() {
    super.initState();
    _lastNameController.text = widget.user!.lastName!;
    _firstNameController.text = widget.user!.firstName!;
    _emailController.text = widget.user!.email!;
    _streetController.text = widget.user!.street!;
    _cityController.text = widget.user!.city!;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _streetController.dispose();
    _cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                          radius: 22,
                          child: IconButton(
                            icon: const Icon(CupertinoIcons.clear),
                            onPressed: () => context.pop(),
                          ))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nom & Prénom(s)',
                          style: Theme.of(context).textTheme.labelLarge),
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
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email',
                          style: Theme.of(context).textTheme.labelLarge),
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
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Rue',
                          style: Theme.of(context).textTheme.labelLarge),
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
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ville',
                          style: Theme.of(context).textTheme.labelLarge),
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
                  const SizedBox(height: 20),
                  PrimaryButton(
                      text: "Valider",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          User updatedUser = User(
                              uuid: widget.user!.uuid,
                              firstName: _firstNameController.text.trim(),
                              lastName: _lastNameController.text.trim(),
                              gender: widget.user!.gender!,
                              email: _emailController.text.trim(),
                              street: _streetController.text.trim(),
                              city: _cityController.text.trim(),
                              picture: widget.user!.picture!);

                          _updateUser(widget.user!.uuid!, updatedUser);
                        }
                      })
                ]),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool isObscureText;
  final String? obscuringCharacter;
  final String hintText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const CustomTextField(
      {Key? key,
      required this.validator,
      required this.controller,
      required this.keyboardType,
      required this.isObscureText,
      this.obscuringCharacter,
      this.suffixIcon,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isObscureText,
      obscuringCharacter:
          obscuringCharacter == null ? '*' : obscuringCharacter!,
      style: TextStyle(
          fontFamily: 'Roboto',
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w500,
          fontSize: 16),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 15, left: 15),
        constraints: BoxConstraints(maxHeight: height * 0.1, maxWidth: width),
        filled: true,
        enabled: true,
        fillColor: Theme.of(context).colorScheme.background,
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(
            fontFamily: 'Roboto',
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
            fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 1.0),
        ),
      ),
    );
  }
}

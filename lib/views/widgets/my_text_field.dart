import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final Function(String?) validator;
  final AutovalidateMode autovalidateMode;

  const MyTextField(
      {Key? key,
      required this.hintText,
      required this.textInputType,
      required this.controller,
      required String? Function(String?) this.validator,
      this.autovalidateMode = AutovalidateMode.always})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        autovalidateMode: autovalidateMode,
        validator: (v) => validator(v),
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hintText,
          // To delete borders
          enabledBorder: OutlineInputBorder(
            borderSide: Divider.createBorderSide(context),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          // fillColor: Colors.red,
          filled: true,
          contentPadding: const EdgeInsets.all(8),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:spotify_clone/common/helpers/is_dark_mode.dart';

class CustomTextfield extends StatelessWidget {
  /// A custom text field widget with a label and validation.
  final String hintText;
  final Function(String)? onChanged;
  const CustomTextfield({
    super.key,
    required this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        labelText: hintText,
        contentPadding: const EdgeInsets.all(30),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: context.isDarkMode ? Colors.white : Colors.black,
            width: 2,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your full name';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}

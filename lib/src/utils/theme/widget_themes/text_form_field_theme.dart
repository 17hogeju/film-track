import 'package:flutter/material.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static TextFormField myTextFormField(icon, labelText, isPassword) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: labelText,
        hintText: labelText,
        border: const OutlineInputBorder(),
        suffixIcon: isPassword ?  const IconButton(
          onPressed: null,
          icon: Icon(Icons.remove_red_eye_rounded)
        ) : null,
      ),
    );
  }

  // static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
  //   style: OutlinedButton.styleFrom(
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(tDefaultSize)),
  //       foregroundColor: tWhiteColor,
  //       side: const BorderSide(color: tWhiteColor),
  //       padding: const EdgeInsets.symmetric(vertical: tButtonHeight)),
  // );
}

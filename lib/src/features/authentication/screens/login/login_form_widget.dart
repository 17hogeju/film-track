import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:filmtrack/src/utils/theme/widget_themes/text_form_field_theme.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: tFormHeight * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TTextFormFieldTheme.lightTextFormField(Icons.person_rounded, tEmail, false),
                const SizedBox(height: tFormHeight),
                TTextFormFieldTheme.lightTextFormField(Icons.lock_rounded, tPassword, true),
                const SizedBox(height: tFormHeight),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: (){},
                      child: const Text(tForgotPassword)
                  ),
                ),
                const SizedBox(height: tFormHeight),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (){},
                        child: Text(tLogin.toUpperCase())
                    )
                )
              ],
            )
        )
    );
  }
}

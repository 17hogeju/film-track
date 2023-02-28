import 'package:filmtrack/src/common_widgets/navigation/authenticated_navigation_widget.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:filmtrack/src/features/authentication/screens/forgot_password/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text(tEmail),
                    prefixIcon: Icon(Icons.mail_rounded),
                  ),
                ),
                const SizedBox(height: tFormHeight),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text(tPassword),
                      prefixIcon: Icon(Icons.lock_rounded),
                      suffixIcon: IconButton(onPressed: null, icon: Icon(Icons.remove_red_eye_rounded)),
                  ),
                ),
                const SizedBox(height: tFormHeight),

                // -- Forgot password button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: (){
                        Get.to(() => const ForgotPasswordScreen());
                      },
                      child: const Text(tForgotPassword)
                  ),
                ),
                const SizedBox(height: tFormHeight),

                // -- Login button
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (){
                          Get.to(() => const AuthenticatedNavigationWidget());
                        },
                        child: Text(tLogin.toUpperCase())
                    )
                )
              ],
            )
        )
    );
  }
}

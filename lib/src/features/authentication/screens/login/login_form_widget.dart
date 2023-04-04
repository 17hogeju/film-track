import 'package:filmtrack/src/common_widgets/navigation/bottom_navigation.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:filmtrack/src/features/authentication/controllers/register_controller.dart';
import 'package:filmtrack/src/features/authentication/screens/forgot_password/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final controller = Get.put(RegisterController());
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;

  void toggleObscure() {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: tFormHeight * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.email,
                  decoration: const InputDecoration(
                    label: Text(tEmail),
                    prefixIcon: Icon(Icons.mail_rounded),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: tFormHeight),
                TextFormField(
                  controller: controller.password,
                  obscureText: obscure,
                  decoration: InputDecoration(
                    label: const Text(tPassword),
                    prefixIcon: const Icon(Icons.lock_rounded),
                    suffixIcon: IconButton(
                        onPressed: toggleObscure,
                        icon: Icon(
                            obscure ? Icons.visibility : Icons.visibility_off)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: tFormHeight),

                // -- Forgot password button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Get.to(() => const ForgotPasswordScreen());
                      },
                      child: const Text(tForgotPassword)),
                ),
                const SizedBox(height: tFormHeight),

                // -- Login button
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            RegisterController.instance.loginUser(
                                controller.email.text.trim(),
                                controller.password.text.trim());
                          }
                        },
                        child: Text(tLogin.toUpperCase())))
              ],
            )));
  }
}

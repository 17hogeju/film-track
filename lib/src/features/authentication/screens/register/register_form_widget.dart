import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:filmtrack/src/features/authentication/controllers/register_controller.dart';
import 'package:filmtrack/src/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({Key? key}) : super(key: key);

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final controller = Get.put(RegisterController());
  final formKey = GlobalKey<FormState>();
  bool obscure1 = true;
  bool obscure2 = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      controller.snackbarFunction = _showSnackBar;
    });
  }

  _showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void toggleObscure1() {
    setState(() {
      obscure1 = !obscure1;
    });
  }

  void toggleObscure2() {
    setState(() {
      obscure2 = !obscure2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
              obscureText: obscure1,
              decoration: InputDecoration(
                label: const Text(tPassword),
                prefixIcon: const Icon(Icons.lock_rounded),
                suffixIcon: IconButton(
                    onPressed: toggleObscure1,
                    icon: Icon(obscure1 ? Icons.visibility : Icons.visibility_off)
                ),
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
            TextFormField(
              controller: controller.confirmPassword,
              obscureText: obscure2,
              decoration: InputDecoration(
                label: const Text(tConfirmPassword),
                prefixIcon: const Icon(Icons.lock_rounded),
                suffixIcon: IconButton(
                    onPressed: toggleObscure2,
                    icon: Icon(obscure2 ? Icons.visibility : Icons.visibility_off)
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please confirm password';
                } else if (controller.password.text != controller.confirmPassword.text) {
                  return 'Passwords must match';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: tFormHeight),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if(formKey.currentState!.validate()) {
                        RegisterController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
                      }
                    },
                    child: Text(tRegister.toUpperCase())
                )
            )
          ],
        )
      )
    );
  }
}

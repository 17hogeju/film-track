import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:filmtrack/src/features/authentication/screens/forgot_password/forgot_password_otp/forgot_password_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text(tEmail),
                prefixIcon: Icon(Icons.mail_rounded),
              ),
            ),
            const SizedBox(height: tFormHeight),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: (){
                      Get.to(() => const ForgotPasswordOtpScreen());
                    },
                    child: Text(tNext.toUpperCase())
                )
            )
          ],
        )
    );
  }
}

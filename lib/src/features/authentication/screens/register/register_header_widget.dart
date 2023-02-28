import 'package:filmtrack/src/common_widgets/form/form_header_widget.dart';
import 'package:filmtrack/src/constants/colors.dart';
import 'package:filmtrack/src/constants/image_strings.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:filmtrack/src/features/authentication/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterHeaderWidget extends StatelessWidget {
  const RegisterHeaderWidget({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FormHeaderWidget(image: tLogoImage, title: tRegisterTitle, hasSubtitle: false),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => Get.to(() => const LoginScreen()),
                child: Text.rich(
                    TextSpan(
                        text: tYesAccount,
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: const [
                          TextSpan(
                              text: tLogin,
                              style: TextStyle(color: tPrimaryColor)
                          )
                        ]
                    )
                )
            )
          ],
        )
      ],
    );
  }
}
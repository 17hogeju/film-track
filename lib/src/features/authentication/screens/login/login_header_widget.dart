import 'package:filmtrack/src/common_widgets/form/form_header_widget.dart';
import 'package:filmtrack/src/constants/colors.dart';
import 'package:filmtrack/src/constants/image_strings.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:filmtrack/src/features/authentication/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FormHeaderWidget(image: tLogoImage, title: tLoginTitle, hasSubtitle: false),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => Get.to(() => const RegisterScreen()),
                child: Text.rich(
                  TextSpan(
                    text: tNoAccount,
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: const [
                      TextSpan(
                        text: tRegister,
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
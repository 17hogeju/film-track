import 'package:filmtrack/src/common_widgets/form/form_header_widget.dart';
import 'package:filmtrack/src/constants/image_strings.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:filmtrack/src/features/authentication/screens/forgot_password/forgot_password_form.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(tDefaultSizeDouble),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  FormHeaderWidget(image: tLogoImage, title: tForgotPassword, hasSubtitle: true, subTitle: tForgotPasswordSubTitle),
                  SizedBox(height: tFormHeight),
                  ForgotPasswordForm(),
                ],
              ),
            ),
          ),
        )
    );
  }
}
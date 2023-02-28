

import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/features/authentication/screens/register/register_form_widget.dart';
import 'package:filmtrack/src/features/authentication/screens/register/register_header_widget.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSizeDouble),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RegisterHeaderWidget(height: height),
                const RegisterFormWidget()
              ],
            )
          ),

        ),
      )
    );
  }
}

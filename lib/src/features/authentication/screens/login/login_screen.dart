import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/features/authentication/screens/login/login_form_widget.dart';
import 'package:filmtrack/src/features/authentication/screens/login/login_header_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                LoginHeaderWidget(height: height),
                const LoginForm(),
              ],
            ),
          ),
      ),
    ));
  }
}
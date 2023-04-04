import 'package:filmtrack/src/common_widgets/safe_wrapper.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:filmtrack/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeWrapper(
      title: tSettings,
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: tDefaultSize * 4),
        const SizedBox(
          width: double.infinity,
          child:
              ElevatedButton(onPressed: null, child: const Text(tUpdateEmail)),
        ),
        const SizedBox(height: tDefaultSize * 2),
        const SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: null, child: const Text(tChangePassword)),
        ),
        const SizedBox(height: tDefaultSize * 2),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                AuthenticationRepository.instance.logout();
              },
              child: const Text(tLogout)),
        ),
      ],
    ));
  }
}

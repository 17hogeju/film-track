import 'package:filmtrack/src/constants/image_strings.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:flutter/material.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            const Image(image: AssetImage(tWelcomeImage)),
            const Text(tAppName),
            const Text(tAppTagline),
            Row(
              children: [
                OutlinedButton(onPressed: (){}, child: const Text(tLogin)),
                ElevatedButton(onPressed: (){}, child: const Text(tRegister)),
              ],
            )
          ]
        )
    );
  }
}
import 'package:filmtrack/src/constants/colors.dart';
import 'package:filmtrack/src/constants/image_strings.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:filmtrack/src/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    // var brightness = mediaQuery.platformBrightness;
    // final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(tDefaultSizeDouble),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(
                      image: const AssetImage(tWelcomeImage),
                      height: height * 0.6),
                  Column(
                    children: [
                      Text(tAppName,
                          style: Theme.of(context).textTheme.headlineMedium),
                      Text(
                        tAppTagline,
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Text(tLogin.toUpperCase()),
                        ),
                      ),
                      const SizedBox(width: tDefaultPaddingWidth),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {},
                            child: Text(tRegister.toUpperCase())),
                      )
                    ],
                  )
                ])));
  }
}

import 'package:filmtrack/src/constants/colors.dart';
import 'package:filmtrack/src/constants/image_strings.dart';
import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:flutter/material.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image(
          image: const AssetImage(tLogoImage),
          color: tPrimaryColor,
          height: height * 0.2,
        ),
        const SizedBox(height: tDefaultPaddingHeight,),
        Text(
            tLoginTitle,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: (){},
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
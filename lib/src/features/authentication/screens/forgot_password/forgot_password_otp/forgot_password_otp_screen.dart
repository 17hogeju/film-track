import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class ForgotPasswordOtpScreen extends StatelessWidget {
  const ForgotPasswordOtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSizeDouble),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(tOtpTitle, style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 80.0
                  )),
                Text(tOtpSubtitle.toUpperCase(), style: Theme.of(context).textTheme.titleSmall,),
                const SizedBox(height: tDefaultSize * 3),
                const Text("$tOtpMessage email from last screen", textAlign: TextAlign.center,),
                const SizedBox(height: tDefaultSize * 3),
                OtpTextField(
                  numberOfFields: 6,
                  fillColor: Colors.black.withOpacity(0.1),
                  filled: true,
                  onSubmit: (code) {
                    print("OTP is $code");
                  },
                ),
                const SizedBox(height: tDefaultSize * 4),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: (){},
                      child: Text(tNext)
                  )
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}

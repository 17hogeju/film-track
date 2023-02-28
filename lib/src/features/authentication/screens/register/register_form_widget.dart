import 'package:filmtrack/src/constants/sizes.dart';
import 'package:filmtrack/src/constants/text_strings.dart';
import 'package:flutter/material.dart';

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: tFormHeight * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text(tEmail),
                    prefixIcon: Icon(Icons.mail_rounded),
                  ),
                ),
                const SizedBox(height: tFormHeight),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text(tPassword),
                    prefixIcon: Icon(Icons.lock_rounded),
                    suffixIcon: IconButton(onPressed: null, icon: Icon(Icons.remove_red_eye_rounded)),
                  ),
                ),
                const SizedBox(height: tFormHeight),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text(tConfirmPassword),
                    prefixIcon: Icon(Icons.lock_rounded),
                    suffixIcon: IconButton(onPressed: null, icon: Icon(Icons.remove_red_eye_rounded)),
                  ),
                ),
                const SizedBox(height: tFormHeight),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (){},
                        child: Text(tRegister.toUpperCase())
                    )
                )
              ],
            )
        )
    );
  }
}

import 'package:filmtrack/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:filmtrack/src/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      home: const WelcomeScreen(),
    );
  }
}

class AppHome extends StatelessWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text(
            'Home',
          ),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                Center(
                  child: Text("Welcome!", style: Theme.of(context).textTheme.headlineMedium,),
                ),
                ElevatedButton(
                  onPressed: () {}, child: const Text("To Watch List"),),
                ElevatedButton(
                  onPressed: () {}, child: const Text("Watched List"),),
                ElevatedButton(
                  onPressed: () {}, child: const Text("Settings"),),
              ],
            )
        )
    );
  }
}
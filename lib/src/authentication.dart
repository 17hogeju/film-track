import 'package:flutter/material.dart';

import 'widgets.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ // Before Login
        Padding(
          padding: const EdgeInsets.only(left: 24, bottom: 8),
          child: StyledButton(
              onPressed: () {
                !loggedIn
                    ? Navigator.of(context).pushNamed('/sign-in')
                    : signOut();
              },
              child:
                  !loggedIn ? const Text('Go To Login') : const Text('Logout')),
        ),
        Visibility( // After logged in
            visible: loggedIn,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: StyledButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/profile');
                  },
                  child: const Text('Profile')),
            )),
        Visibility(
          visible: loggedIn,
          child: LongButtons(textColor: Colors.black,
            backgroundColor: Colors.white,
            text: "To Watch List",
            icon: Icons.push_pin_rounded,
            onPressed: () {
              Navigator.of(context).pushNamed('/to-watch-list');
            },
          ),
        ),
        Visibility(
          visible: loggedIn,
          child: LongButtons(textColor: Colors.black,
            backgroundColor: Colors.white,
            text: "Watched List",
            icon: Icons.star_rounded,
            onPressed: () {
              Navigator.of(context).pushNamed('/watched-list');
            },
          ),
        ),
        Visibility(
          visible: loggedIn,
          child: LongButtons(textColor: Colors.black,
            backgroundColor: Colors.white,
            text: "Settings",
            icon: Icons.settings_rounded,
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
          ),
        ),
        Visibility(
            visible: loggedIn,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: StyledButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/recommendations');
                  },
                  child: const Text('Recommendations')),
            ))
      ],
    );
  }
}

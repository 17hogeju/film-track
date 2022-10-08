
import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'src/authentication.dart';
// import 'src/widgets.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const App()),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mfaAction = AuthStateChangeAction<MFARequired>(
          (context, state) async {
        final nav = Navigator.of(context);

        await startMFAVerification(
          resolver: state.resolver,
          context: context,
        );

        unawaited(nav.pushReplacementNamed('/profile'));
      },
    );

    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) {
          return const HomePage();
        },
        '/sign-in': ((context) {
          return SignInScreen(
            actions: [
              ForgotPasswordAction(((context, email) {
                Navigator.of(context)
                    .pushNamed('/forgot-password', arguments: {'email': email});
              })),
              AuthStateChangeAction(((context, state) {
                if (state is SignedIn || state is UserCreated) {
                  var user = (state is SignedIn)
                      ? state.user
                      : (state as UserCreated).credential.user;
                  if (user == null) {
                    return;
                  }
                  if (state is UserCreated) {
                    user.updateDisplayName(user.email!.split('@')[0]);
                    user.sendEmailVerification();
                  }
                  if (!user.emailVerified) {
                    user.sendEmailVerification();
                    const snackBar = SnackBar(
                        content: Text(
                            'Please check your email to verify your email address'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  Navigator.of(context).popUntil(ModalRoute.withName('/home'));
                }
              })),
              mfaAction,
            ],
          );
        }),
        '/forgot-password': ((context) {
          final arguments = ModalRoute.of(context)?.settings.arguments
          as Map<String, dynamic>?;

          return ForgotPasswordScreen(
            email: arguments?['email'] as String,
            headerMaxExtent: 200,
          );
        }),
        '/profile': ((context) {
          return Consumer<ApplicationState>(
            builder: (context, appState, _) => ProfileScreen(
              key: ValueKey(appState.emailVerified),
              providers: const [],
              showMFATile: appState.emailVerified,
              actions: [
                SignedOutAction(
                  ((context) {
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName('/home'));
                  }),
                ),
              ],
              children: [
                Visibility(
                  visible: !appState.emailVerified,
                  child: OutlinedButton(
                    onPressed: () {
                      appState.refreshLoggedInUser();
                    },
                    child: const Text('Re-check email verification status'),
                  ),
                ),
              ],
            ),
          );
        })
      },
      title: 'Dashboard',
      theme: ThemeData(
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
          highlightColor: Colors.deepPurple,
        ),
        primarySwatch: Colors.deepPurple,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 8),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => AuthFunc(
                loggedIn: appState.loggedIn,
                signOut: () {
                  FirebaseAuth.instance.signOut();
                }),
          ),
        ],
      ),
    );
  }
}

enum Attending { yes, no, unknown }

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  bool _emailVerified = false;
  bool get emailVerified => _emailVerified;
  // String _uid = "";

  // StreamSubscription<QuerySnapshot>? _userDataSubscription;
  // UserDataDocument _userDataDocument = ;
  // List<UserDataDocument> get userDataDocuments => _userDataDocuments;


  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _emailVerified = user.emailVerified;
  //       _uid = user.uid;
  //       _userDataSubscription = FirebaseFirestore.instance
  //           .collection('userdata')
  //           .where('uid', isEqualTo: _uid)
  //           .snapshots()
  //           .listen((snapshot) {
  //         _userDataDocuments = [];
  //         for (final document in snapshot.docs) {
  //           _guestBookMessages.add(
  //             GuestBookMessage(
  //               name: document.data()['name'] as String,
  //               message: document.data()['text'] as String,
  //             ),
  //           );
  //         }
  //         notifyListeners();
  //       });
  //       _attendingSubscription = FirebaseFirestore.instance
  //           .collection('attendees')
  //           .doc(user.uid)
  //           .snapshots()
  //           .listen((snapshot) {
  //         if (snapshot.data() != null) {
  //           if (snapshot.data()!['attending'] as bool) {
  //             _attending = Attending.yes;
  //           } else {
  //             _attending = Attending.no;
  //           }
  //         } else {
  //           _attending = Attending.unknown;
  //         }
  //         notifyListeners();
  //       });
      } else {
        _loggedIn = false;
        // _guestBookMessages = [];
        // _guestBookSubscription?.cancel();
        // _attendingSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  Future<void> refreshLoggedInUser() async {
    if (!loggedIn) {
      return;
    }
    await FirebaseAuth.instance.currentUser!.reload();
  }

  // Future<DocumentReference> addMessageToGuestBook(String message) {
  //   if (!_loggedIn) {
  //     throw Exception('Must be logged in');
  //   }
  //
  //   return FirebaseFirestore.instance
  //       .collection('guestbook')
  //       .add(<String, dynamic>{
  //     'text': message,
  //     'timestamp': FieldValue.serverTimestamp(),
  //     'name': FirebaseAuth.instance.currentUser!.displayName,
  //     'userId': FirebaseAuth.instance.currentUser!.uid,
  //     /**
  //         DISCLAIMER:
  //         This is for testing only. In practice, you would want
  //         to use a fixed date such as:
  //         'ttl': DateTime.parse('2022-10-31'),
  //      **/
  //     'ttl': DateTime.now().add(const Duration(minutes: 1)),
  //   });
  // }
}

// class UserDataDocument {
//
//   String username;
//   Integer budget;
//   String subscriptions;
//   UserDataDocument._(this.username, this.budget, this.subscriptions);
//
//   factory UserDataDocument({@required String username, @required})
// }

// class UserData extends StatefulWidget {
//   const UserData({
//     super.key,
//     required this.userDocuments,
//   });
//
//   final List<UserDataDocument> userDocuments;
//
//   @override
//   State<UserData> createState() => _UserDataState();
// }

// class _UserDataState extends State<UserData> {
//   final _formKey = GlobalKey<FormState>(debugLabel: '_UserDataState');
//   final _controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Form(
//             key: _formKey,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: _controller,
//                     decoration: const InputDecoration(
//                       hintText: 'Leave a message',
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Enter your message to continue';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 StyledButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       await widget.addMessage(_controller.text);
//                       _controller.clear();
//                     }
//                   },
//                   child: Row(
//                     children: const [
//                       Icon(Icons.send),
//                       SizedBox(width: 4),
//                       Text('SEND'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         for (var message in widget.messages)
//           Paragraph('${message.name}: ${message.message}'),
//         const SizedBox(height: 8),
//       ],
//     );
//   }
// }

// class YesNoSelection extends StatelessWidget {
//   const YesNoSelection(
//       {super.key, required this.state, required this.onSelection});
//   final Attending state;
//   final void Function(Attending selection) onSelection;
//
//   @override
//   Widget build(BuildContext context) {
//     switch (state) {
//       case Attending.yes:
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(elevation: 0),
//                 onPressed: () => onSelection(Attending.yes),
//                 child: const Text('YES'),
//               ),
//               const SizedBox(width: 8),
//               TextButton(
//                 onPressed: () => onSelection(Attending.no),
//                 child: const Text('NO'),
//               ),
//             ],
//           ),
//         );
//       case Attending.no:
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               TextButton(
//                 onPressed: () => onSelection(Attending.yes),
//                 child: const Text('YES'),
//               ),
//               const SizedBox(width: 8),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(elevation: 0),
//                 onPressed: () => onSelection(Attending.no),
//                 child: const Text('NO'),
//               ),
//             ],
//           ),
//         );
//       default:
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               StyledButton(
//                 onPressed: () => onSelection(Attending.yes),
//                 child: const Text('YES'),
//               ),
//               const SizedBox(width: 8),
//               StyledButton(
//                 onPressed: () => onSelection(Attending.no),
//                 child: const Text('NO'),
//               ),
//             ],
//           ),
//         );
//     }
//   }
// }
import 'package:filmtrack/src/common_widgets/navigation/bottom_navigation.dart';
import 'package:filmtrack/src/features/authentication/models/user_model.dart';
import 'package:filmtrack/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:filmtrack/src/repository/authentication_repository/exceptions/register_email_password_failure.dart';
import 'package:filmtrack/src/repository/user_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  final _userRepo = Get.put(UserRepository());

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 6));
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const WelcomeScreen()) : Get.offAll(() => const BottomNavigation());
  }

  Future<void> registerUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (firebaseUser.value != null) {
        _userRepo.createUser(firebaseUser.value!.uid);
        Get.offAll(() => const BottomNavigation());
      } else {
        Get.to(() => const WelcomeScreen());
      }
    } on FirebaseAuthException catch(e) {
      final ex = RegisterWithEmailAndPasswordFailure.code(e.code);
      throw ex;
    } catch (_) {
      const ex = RegisterWithEmailAndPasswordFailure();
      throw ex;
    }
  }

  Future<void> loginUserWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    if (firebaseUser.value != null) {
      UserRepository.instance.createUser(firebaseUser.value!.uid);
      Get.offAll(() => const BottomNavigation());
    } else {
      Get.to(() => const WelcomeScreen());
    }
  }

  Future<void> logout() async => await _auth.signOut();
}

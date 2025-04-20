import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_app/core/errors/exceptions.dart';
import 'package:fruits_app/core/errors/handle_login_emailandpassword.dart';
import 'package:fruits_app/core/errors/handle_register_exception.dart';
import 'package:fruits_app/core/helper/local_helper.dart';

import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthService {
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<User> login({required String email, required String password});
  Future<User> signInWithGoogle();
  Future deleteUser();
}

class FirebaseAuthService extends AuthService {
  @override
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      throw handleFirebaseRegisterException(e);
    } catch (e) {
      throw CustomException(
        getLocal() == 'ar'
            ? 'حدث خطأ ما يرجى المحاولة مرة أخرى'
            : 'there is an error try later',
      );
    }
  }

  @override
  Future<User> login({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      throw handleFirebaseLoginEAPException(e);
    } catch (e) {
      throw CustomException(
        getLocal() == 'ar'
            ? 'حدث خطأ ما يرجى المحاولة مرة أخرى'
            : 'there is an error try later',
      );
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
  }

  @override
  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }
}

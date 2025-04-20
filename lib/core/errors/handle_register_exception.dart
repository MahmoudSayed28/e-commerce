import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_app/core/errors/exceptions.dart';
import 'package:fruits_app/core/helper/local_helper.dart';

CustomException handleFirebaseRegisterException(FirebaseAuthException e) {
  final bool isArabic = getLocal() == 'ar';

  switch (e.code) {
    case 'weak-password':
      return CustomException(
        isArabic ? 'كلمة المرور ضعيفة' : 'The password provided is too weak.',
      );
    case 'invalid-email':
      return CustomException(
        isArabic ? 'البريد الإلكتروني غير صالح' : 'Invalid email address',
      );
    case 'email-already-in-use':
      return CustomException(
        isArabic
            ? 'الحساب موجود بالفعل لهذا البريد الإلكتروني'
            : 'The account already exists for that email.',
      );
    case 'network-request-failed':
      return CustomException(
        isArabic ? 'لا يوجد اتصال بالإنترنت' : 'No internet connection',
      );
    default:
      return CustomException(
        isArabic
            ? 'حدث خطأ ما يرجى المحاولة مرة أخرى'
            : 'An error occurred. Please try again later.',
      );
  }
}

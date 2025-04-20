import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_app/core/errors/exceptions.dart';
import 'package:fruits_app/core/helper/local_helper.dart';

CustomException handleFirebaseLoginEAPException(FirebaseAuthException e) {
  final isArabic = getLocal() == 'ar';

  switch (e.code) {
    case 'wrong-password':
      return CustomException(
        isArabic ? 'كلمة المرور غير صحيحة' : 'Wrong password provided.',
      );
    case 'user-not-found':
      return CustomException(
        isArabic
            ? 'لا يوجد مستخدم بهذا البريد الإلكتروني'
            : 'No user found with this email.',
      );
    case 'invalid-email':
      return CustomException(
        isArabic
            ? 'البريد الإلكتروني غير صالح'
            : 'The email address is badly formatted.',
      );
    case 'user-disabled':
      return CustomException(
        isArabic
            ? 'تم تعطيل هذا المستخدم'
            : 'This user account has been disabled.',
      );
    case 'too-many-requests':
      return CustomException(
        isArabic
            ? 'لقد قمت بعدد كبير من المحاولات، حاول لاحقًا'
            : 'Too many attempts. Try again later.',
      );
    case 'operation-not-allowed':
      return CustomException(
        isArabic
            ? 'هذا النوع من الدخول غير مفعل حالياً'
            : 'This sign-in method is not enabled.',
      );
    case 'invalid-credential':
      return CustomException(
        isArabic ? 'بيانات الدخول غير صالحة' : 'Invalid login credentials.',
      );
    case 'network-request-failed':
      return CustomException(
        isArabic ? 'لا يوجد اتصال بالإنترنت' : 'No internet connection.',
      );
    default:
      return CustomException(
        isArabic
            ? 'حدث خطأ غير متوقع، حاول مرة أخرى لاحقاً'
            : 'An unexpected error occurred. Please try again later.',
      );
  }
}

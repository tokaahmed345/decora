import 'package:decora/feature/auth/data/models/forgot_password_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  ForgotRemoteDataSource({required this.firebaseAuth});

  Future<ForgotPasswordModel> resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);

    return ForgotPasswordModel
    (email: email);
  }
}
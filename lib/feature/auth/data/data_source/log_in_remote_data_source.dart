import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/auth/data/models/log_in_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LogInRemoteDataSource {
    final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  LogInRemoteDataSource({required this.firebaseAuth, required this.firestore, });

Future<LogInModel> logIn({
  required String email,
  required String password,
}) async {
  final userCredential = await firebaseAuth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );

  final token = await getIt.get<FirebaseMessaging>().getToken();
  if (token != null) {
    await firestore.collection('user').doc(userCredential.user!.uid).update({
      'fcmToken': token,
    });
  }

  final user = LogInModel(
    id: userCredential.user!.uid,
    email: email,
  );

  return user;
}
}
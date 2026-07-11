import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decora/feature/auth/data/models/sign_up_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignUpRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  SignUpRemoteDataSource({required this.firebaseAuth, required this.firestore});

  Future<SignUpModel> signUp({
  required String name,
  required String email,
  required String password,
}) async {
  final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

  final token = await FirebaseMessaging.instance.getToken();

  final user = SignUpModel(
    id: userCredential.user!.uid,
    fullName: name,
    email: email,
  );

  final userMap = user.toMap();
  userMap['fcmToken'] = token ?? '';

  await firestore.collection('user').doc(user.id).set(userMap);

  return user;
}
}
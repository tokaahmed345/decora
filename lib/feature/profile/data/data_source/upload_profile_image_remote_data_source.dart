import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadProfileImageRemoteDataSource {
  final SupabaseClient supabase;
  final FirebaseFirestore firestore;

  UploadProfileImageRemoteDataSource({
    required this.supabase,
    required this.firestore,
  });

  Future<String> uploadUserImage(String userId, File file) async {
    try {
      final fileName =
          'profile_${DateTime.now().millisecondsSinceEpoch}_$userId.png';

      await supabase.storage.from('profile').uploadBinary(
            fileName,
            await file.readAsBytes(),
            fileOptions: const FileOptions(upsert: true),
          );

      final publicUrl =
          supabase.storage.from('profile').getPublicUrl(fileName);

      await firestore.collection('user').doc(userId).set(
        {
          'imageUrl': publicUrl,
          'uploadedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );

      return '$publicUrl?t=${DateTime.now().millisecondsSinceEpoch}';
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      final doc = await firestore.collection('user').doc(userId).get();
      return doc.data();
    } catch (e) {
      throw Exception('Failed to fetch user data: $e');
    }
  }
}
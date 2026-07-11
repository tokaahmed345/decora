import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class NotificationRemoteData {
  Future<String> _getAccessToken() async {
    final jsonString = await rootBundle.loadString(
      'lib/core/utils/decora-8da7b-32886d272f85.json',
    );
    final jsonMap = json.decode(jsonString);

    final credentials = ServiceAccountCredentials.fromJson(jsonMap);
    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final client = await clientViaServiceAccount(credentials, scopes);
    return client.credentials.accessToken.data;
  }

  Future<int> sendPushNotification({
    required String token,
    required String title,
    required String body,
  }) async {
    final accessToken = await _getAccessToken();
    final projectId = 'decora-8da7b';

    final response = await http.post(
      Uri.parse(
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: json.encode({
        'message': {
          'token': token,
          'notification': {
            'title': title,
            'body': body,
          },
        },
      }),
    );

    return response.statusCode;
  }

  Future<void> updateFcmToken() async {
    final user = getIt.get<FirebaseAuth>().currentUser;
    if (user == null) return;

    try {
      final token = await getIt.get<FirebaseMessaging>().getToken();
      if (token != null) {
        await _saveFcmToken(token);
      }
    } catch (e) {
      debugPrint('FCM token update failed: $e');
    }
  }

  Future<void> _saveFcmToken(String token) async {
    final user =getIt.get<FirebaseAuth>().currentUser;
    if (user == null) return;

    try {
      await getIt.get<FirebaseFirestore>()
          .collection('user')
          .doc(user.uid)
          .update({'fcmToken': token});
    } catch (e) {
      debugPrint('Saving FCM token failed: $e');
    }
  }

  void listenToFcmTokenRefresh() {
  getIt.get<FirebaseMessaging>().onTokenRefresh.listen((newToken) {
      _saveFcmToken(newToken);
    });
  }
  Future<void> requestNotificationPermission() async {
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    sound: true,
    badge: true,
  );
}
}
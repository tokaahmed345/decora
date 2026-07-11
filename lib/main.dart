import 'package:decora/core/utils/router/app_router.dart';
import 'package:decora/core/utils/service_locator/service_locator.dart';
import 'package:decora/feature/notification/data/notification_remote_data_layer.dart/data_source/notification_remote_data.dart';
import 'package:decora/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  setupServiceLocator();

  await getIt<NotificationRemoteData>().requestNotificationPermission();

  await getIt<NotificationRemoteData>().updateFcmToken();
  getIt<NotificationRemoteData>().listenToFcmTokenRefresh();
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}

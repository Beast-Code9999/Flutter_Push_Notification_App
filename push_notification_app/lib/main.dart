import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:push_notification_app/firebase_options.dart';
import 'package:push_notification_app/screens/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(PushNotificationApp());
}

class PushNotificationApp extends StatelessWidget {
  const PushNotificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Push Notifcation App",
      home: AuthGate(),
    );
  }
}
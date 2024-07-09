import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_push_notification/src/app/app.dart';
import 'package:flutter_push_notification/src/config/dependency_injection.dart';
import 'package:flutter_push_notification/src/domain/notification/notifications.dart';
import 'package:watch_it/watch_it.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  registerDependencies();
  final notificationService = di<Notifications>();
  await notificationService.initialize();
 
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(( const App()));
  });
}

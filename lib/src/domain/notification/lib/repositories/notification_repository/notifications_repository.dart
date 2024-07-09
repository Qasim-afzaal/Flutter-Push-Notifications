import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationRepository with ChangeNotifier {
  NotificationRepository._();
  static final NotificationRepository instance = NotificationRepository._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;

  Future<void> initialize() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        _handleNotificationClick(payload);
      },
    );

    // Create notification channel
    await _createNotificationChannel();

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await getDeviceToken();
      if (token != null) {
        await _firebaseMessaging.subscribeToTopic('all');
      
      }
    }

    listenToNotifications();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<String?> getDeviceToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      print('Device Token: $token');
      return token;
    } catch (e) {
      print('Error getting device token: $e');
      return null;
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      print('Subscribed to topic: $topic');
    } catch (e) {
      print('Error subscribing to topic: $e');
    }
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      print('Unsubscribed from topic: $topic');
    } catch (e) {
      print('Error unsubscribing from topic: $e');
    }
  }

  void listenToNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Do not show notification while in foreground
      print('Foreground Message Received: ${message.notification?.title}');
      _firebaseAnalytics.logEvent(
        name: 'notification_received',
        parameters: {
          'title': message.notification?.title,
          'body': message.notification?.body,
        },
      );
      // Log the message but do not show notification
      print('Foreground Message : ${message.notification!.body}');
      print('Foreground Message : ${message.notification!.body}');
      print('Foreground Message : ${message.data}');
      print('Message data: ${message.data}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Background Message Clicked: ${message.notification?.title}');
      _firebaseAnalytics.logEvent(
        name: 'notification_opened',
        parameters: {
          'title': message.notification?.title,
          'body': message.notification?.body,
        },
      );
      print('Background Message Clicked: ${message.notification!.body}');
      print('Background Message Clicked: ${message.notification!.body}');
      print('Background Message Clicked: ${message.data.isEmpty}');

      _handleNotificationClick(message.notification!.title);
    });
  }

  Future<void> _showNotification(RemoteMessage message) async {
    try {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      );

      const IOSNotificationDetails iOSPlatformChannelSpecifics =
          IOSNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      await _flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        platformChannelSpecifics,
        payload: message.data['profile_image_url'],
      );
    } catch (e) {
      print('Error showing notification: $e');
    }
  }



  Future<void> _handleNotificationClick(String? payload) async {
    print('Handling notification click with payload: $payload');

    if (payload != null) {
      // Parse the payload as needed
      // final Map<String, dynamic> data = jsonDecode(payload);
      // print('Parsed Payload: $data');

      // Implement navigation or handling logic based on the data
      // Example:

      // Navigator.of(context).pushNamed('/specificScreen', arguments: data);
    } else {
      print('No payload data received.');
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
    NotificationRepository.instance._showNotification(message);
  }
}

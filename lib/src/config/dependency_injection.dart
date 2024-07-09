
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_push_notification/src/app/screens/activity/activity_controller.dart';
import 'package:flutter_push_notification/src/domain/notification/lib/repositories/activity_repository.dart';
import 'package:flutter_push_notification/src/domain/notification/notifications.dart';
import 'package:watch_it/watch_it.dart';

void registerDependencies() {
  _registerServices();
  _registerRepositories();
  _registerControllers();
}

void _registerServices() {
  di.registerLazySingleton<FirebaseMessaging>(() => FirebaseMessaging.instance);
}

void _registerRepositories() {
  di.registerLazySingleton<ActivityRespository>(
      () => ActivityRespository.instance);
  di.registerLazySingleton<Notifications>(() => Notifications.instance);
}

void _registerControllers() {
  di.registerLazySingleton<BuyerActivityController>(
      () => BuyerActivityController.instance);
}

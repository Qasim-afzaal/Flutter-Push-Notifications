import 'package:flutter/material.dart';
import 'package:flutter_push_notification/src/domain/notification/lib/repositories/activity_repository.dart';
import 'package:flutter_push_notification/src/domain/notification/notifications.dart';

import 'package:watch_it/watch_it.dart';

final ActivityRespository _activityRespository = di<ActivityRespository>();
final Notifications _notifications = di<Notifications>();

class BuyerActivityController {
  BuyerActivityController._();

  static BuyerActivityController get instance => BuyerActivityController._();
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  Future<void> getAllAcivityLogs() async {
    isLoading.value=true;
    try {
      print("i am here");
      await _activityRespository.getAllAcivityLogs();
      isLoading.value=false;
    } catch (e) {
      print(e);
      isLoading.value=false;
      throw e.toString();
    }
  }
   Future<void> listenToNotifications() async {
    isLoading.value=true;
    try {
      print("i am here");
       _notifications.listenToNotifications();
       
      isLoading.value=false;
    } catch (e) {
      print(e);
      isLoading.value=false;
      throw e.toString();
    }
  }
}

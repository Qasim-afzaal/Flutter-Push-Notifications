
import 'package:flutter_push_notification/src/domain/notification/lib/repositories/activity_repository.dart';
import 'package:flutter_push_notification/src/domain/notification/notifications.dart';

final ActivityRespository _activityRespository = ActivityRespository.instance;

class Notifications {
  Notifications._();
  static final Notifications instance = Notifications._();
  final NotificationRepository _notificationRepository =
      NotificationRepository.instance;


  Future<void> subscribeToTopic(String topic) async {
    await _notificationRepository.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _notificationRepository.unsubscribeFromTopic(topic);
  }

  Future<void> initialize() async {
    await _notificationRepository.initialize();
  }

  Future<void> getDeviceToken() async {
    await _notificationRepository.getDeviceToken();
  }

  void listenToNotifications() {
    _notificationRepository.listenToNotifications();
    _activityRespository.getAllAcivityLogs();
  }
}

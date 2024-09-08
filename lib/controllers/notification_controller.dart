import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final notification = FlutterLocalNotificationsPlugin().obs;

  @override
  void onInit() {
    super.onInit();
    initializeNotification();
  }

  void initializeNotification() async {
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await notification.value.initialize(initializationSettings);
  }

  void showNotification() async {
    var androidDetails = const AndroidNotificationDetails(
      'channelId', 'channelName',
      importance: Importance.max, priority: Priority.high,
    );
    var iosDetails = const DarwinNotificationDetails();
    var notificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await notification.value.show(
      0,
      'Peringatan',
      'Notifikasi berhasil diaktifkan',
      notificationDetails,
    );
  }
}
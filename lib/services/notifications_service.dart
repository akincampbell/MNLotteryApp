import '../config.dart';
// ignore: uri_does_not_exist
import 'package:firebase_messaging/firebase_messaging.dart' as fb_msg;

class NotificationsService {
  static final NotificationsService _i = NotificationsService._internal();
  factory NotificationsService() => _i;
  NotificationsService._internal();
  String? lastMockMessage;
  Future<void> init() async { if (!kMockMode) { await fb_msg.FirebaseMessaging.instance.requestPermission(); await fb_msg.FirebaseMessaging.instance.getToken(); } }
  Future<void> sendDemoReminder() async { lastMockMessage = "Reminder: 2nd chance drawing ends tonight!"; }
}

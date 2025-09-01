// Analytics wrapper with mock mode support.
import 'package:flutter/foundation.dart';
import '../config.dart';
// ignore: uri_does_not_exist
import 'package:firebase_analytics/firebase_analytics.dart' as fb_analytics;

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  // Keep a simple in-memory list to display on the Analytics page in Mock Mode.
  final List<Map<String, dynamic>> _mockEvents = [];
  List<Map<String, dynamic>> get events => List.unmodifiable(_mockEvents);

  // IMPORTANT: parameters typed to Map<String, Object>? to satisfy your SDK.
  Future<void> logEvent(String name, {Map<String, Object>? params}) async {
    if (kMockMode) {
      _mockEvents.add({
        'name': name,
        'params': params ?? <String, Object>{},
        'ts': DateTime.now().toIso8601String(),
      });
      debugPrint('[MOCK ANALYTICS] $name ${params ?? {}}');
    } else {
      try {
        await fb_analytics.FirebaseAnalytics.instance
            .logEvent(name: name, parameters: params);
      } catch (e) {
        debugPrint('Analytics error: $e');
      }
    }
  }
}

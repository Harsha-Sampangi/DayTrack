import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../core/constants/app_constants.dart';
import '../core/constants/app_strings.dart';

/// Notification service for task reminders, daily expense reminders,
/// and spending limit alerts.
///
/// Call [init] once in main.dart before using any other method.
class NotificationService {
  NotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// Whether the plugin has been initialised successfully.
  static bool _initialised = false;

  /// Initialize the notification plugin with platform-specific settings.
  static Future<void> init() async {
    try {
      // Android init settings
      const androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      // iOS init settings
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      final result = await _plugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      _initialised = result ?? false;

      if (_initialised) {
        debugPrint('NotificationService: Initialized successfully');
      }
    } catch (e) {
      debugPrint('NotificationService: Init failed — $e');
      _initialised = false;
    }
  }

  /// Handle notification tap.
  static void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Notification tapped: ${response.payload}');
    // Navigation can be handled here via a GlobalKey<NavigatorState>
  }

  // ── Notification Details ──────────────────────────────────────────────

  static NotificationDetails get _notificationDetails {
    const androidDetails = AndroidNotificationDetails(
      AppConstants.notifChannelId,
      AppConstants.notifChannelName,
      channelDescription: 'Notifications for Life Manager app',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    return const NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
  }

  // ── Show Immediate Notification ───────────────────────────────────────

  /// Show a notification immediately (e.g. spending limit exceeded).
  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    if (!_initialised) return;
    try {
      await _plugin.show(id, title, body, _notificationDetails,
          payload: payload);
    } catch (e) {
      debugPrint('NotificationService: showNotification failed — $e');
    }
  }

  /// Show a spending limit exceeded notification.
  static Future<void> showLimitExceeded({
    required String limitType,
    required double spent,
    required double limit,
  }) async {
    await showNotification(
      id: DateTime.now().millisecond,
      title: AppStrings.limitExceededTitle,
      body: 'Your $limitType spending (₹${spent.toStringAsFixed(0)}) '
          'has exceeded the limit of ₹${limit.toStringAsFixed(0)}!',
      payload: 'limit_exceeded',
    );
  }

  /// Show a task reminder notification.
  static Future<void> showTaskReminder({
    required int id,
    required String taskTitle,
  }) async {
    await showNotification(
      id: id,
      title: AppStrings.taskReminderTitle,
      body: taskTitle,
      payload: 'task_reminder',
    );
  }

  /// Show the daily expense reminder.
  static Future<void> showDailyReminder() async {
    await showNotification(
      id: AppConstants.dailyReminderNotifId,
      title: AppStrings.dailyReminderTitle,
      body: AppStrings.dailyReminderBody,
      payload: 'daily_reminder',
    );
  }

  // ── Cancel ────────────────────────────────────────────────────────────

  /// Cancel a specific notification by ID.
  static Future<void> cancel(int id) async {
    if (!_initialised) return;
    await _plugin.cancel(id);
  }

  /// Cancel all notifications.
  static Future<void> cancelAll() async {
    if (!_initialised) return;
    await _plugin.cancelAll();
  }
}

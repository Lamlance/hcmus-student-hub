import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  final _localNotificationService = FlutterLocalNotificationsPlugin();
  static const _channelId = "STUDENT_HUB_ID";
  static const _channelName = "STUDENT_HUB";
  LocalNotificationService() {
    initialize();
  }
  Future<void> initialize() async {
    _configureLocalTimeZone();

    const androidInitalizeSetting =
        AndroidInitializationSettings("@drawable/ic_stat_school");

    const InitializationSettings settings =
        InitializationSettings(android: androidInitalizeSetting);

    await _localNotificationService.initialize(settings);
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Asia/Ho_Chi_Minh"));
  }

  Future<NotificationDetails> _notificationDetail() async {
    const notification = AndroidNotificationDetails(_channelId, _channelName,
        importance: Importance.max, channelDescription: "description");
    return const NotificationDetails(android: notification);
  }

  tz.TZDateTime? _convertTime(DateTime date) {
    tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      date.year,
      date.month,
      date.day,
      date.hour,
      date.minute,
    );

    final tz.TZDateTime lessThan10MinSchedule =
        scheduleDate.subtract(const Duration(minutes: 10));
    final mor1MinNow =
        tz.TZDateTime.now(tz.local).add(const Duration(minutes: 1));

    return lessThan10MinSchedule.compareTo(mor1MinNow) <= 0
        ? null
        : lessThan10MinSchedule;
  }

  Future<void> showNotification(
      {required int id, required String title, required String body}) async {
    final detail = await _notificationDetail();
    await _localNotificationService.show(id, title, body, detail);
  }

  Future<bool> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime time,
  }) async {
    final detail = await _notificationDetail();
    final scheduleDate = _convertTime(time);

    if (scheduleDate == null) return false;

    await _localNotificationService.zonedSchedule(
        id, title, body, scheduleDate, detail,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
    return true;
  }
}

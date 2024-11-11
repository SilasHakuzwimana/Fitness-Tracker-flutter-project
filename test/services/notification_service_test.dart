import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fitness_tracker/services/notification_service.dart';

void main() {
  late NotificationService notificationService;
  // ignore: unused_local_variable
  late FlutterLocalNotificationsPlugin mockNotificationsPlugin;

  setUp(() {
    mockNotificationsPlugin = FlutterLocalNotificationsPlugin();
    notificationService = NotificationService();
  });

  group('NotificationService', () {
    test('initialize should configure notification settings', () async {
      await notificationService.initialize();
      expect(notificationService.flutterLocalNotificationsPlugin, isNotNull);
    });

    testWidgets('showDailyNotification should schedule daily notification',
        (WidgetTester tester) async {
      await notificationService.showDailyNotification();
      
      final pendingNotificationRequests = 
          await notificationService.flutterLocalNotificationsPlugin.pendingNotificationRequests();
      
      expect(pendingNotificationRequests.isNotEmpty, true);
      if (pendingNotificationRequests.isNotEmpty) {
        final notification = pendingNotificationRequests.first;
        expect(notification.id, 0);
        expect(notification.title, 'Daily Fitness Reminder');
        expect(notification.body, 'Track your steps and workouts!');
      }
    });

    test('notification plugin should be properly instantiated', () {
      expect(notificationService.flutterLocalNotificationsPlugin, isA<FlutterLocalNotificationsPlugin>());
    });

    test('showDailyNotification should handle errors gracefully', () async {
      try {
        await notificationService.showDailyNotification();
        expect(true, isTrue);
      } catch (e) {
        fail('Should not throw an exception');
      }
    });
  });
}

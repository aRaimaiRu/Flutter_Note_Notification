import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> scheduleWeeklyAnyDayTimeNotification() async {
  tz.TZDateTime time = nextInstanceDayAndHour(5, 0, 0);
  String stime = time.toString();
  String mytime = stime.splitMapJoin((new RegExp('[0-9]')),
      onMatch: (m) => '${m.group(0)}', onNonMatch: (n) => '*'); // *shoots*
  //String myid = stime.substring(0, 4) + stime.substring(5, 7)+stime.substring(startIndex);
  print("time = $mytime");
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'weekly scheduled notification title',
      'weekly scheduled notification body',
      nextInstanceDayAndHour(5, 0, 0),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'weekly notification channel id',
            'weekly notification channel name',
            'weekly notificationdescription'),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
}

Future<void> NextHourAndMin(
    int hour, int min, String title, String body) async {
  tz.TZDateTime schedule = nextInstanceOfanytime(hour, min);
  final List<PendingNotificationRequest> pendingNotificationRequests =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  await flutterLocalNotificationsPlugin.zonedSchedule(
    pendingNotificationRequests.length,
    '${title}',
    '${body}',
    schedule,
    const NotificationDetails(
      android: AndroidNotificationDetails('daily notification channel id',
          'daily notification channel name', 'daily notification description'),
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    payload: schedule.toString(),
  );
}

//Any day and hour
tz.TZDateTime nextInstanceDayAndHour(int day, int hour, int min) {
  tz.TZDateTime scheduledDate = nextInstanceOfanytime(hour, min);
  while (scheduledDate.weekday != day) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  scheduledDate = scheduledDate.add(Duration(minutes: 18));
  print("scheduledDate = $scheduledDate");
  return scheduledDate;
}

//any time
tz.TZDateTime nextInstanceOfanytime(int hour, int min) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, min);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

//show pending noti
Future<void> checkPendingNotificationRequests(context) async {
  final List<PendingNotificationRequest> pendingNotificationRequests =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  String text;
  for (var i in pendingNotificationRequests) {
    print("${i.id} ${i.title} ${i.payload}\n");
  }
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content:
          Text('${pendingNotificationRequests.length} pending notification '
              'requests ${text} '),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

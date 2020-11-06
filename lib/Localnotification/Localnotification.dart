import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

List indexToDay = [
  null,
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thrusday",
  "Friday",
  "Saturday",
  "Sunday"
];
Future<void> scheduleWeeklyAnyDayTimeNotification(
    List day, int hour, int min, String title, String text) async {
  tz.TZDateTime schedule = nextInstanceOfanytime(hour, min);
  for (int i = 0; i < day.where((item) => item == false).length; i++) {
    schedule = _getDatebyDayList(day, schedule);
    if (schedule == null) {
      continue;
    }
    await flutterLocalNotificationsPlugin.zonedSchedule(
        schedule.hashCode,
        '${title}',
        '${text}',
        schedule,
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'weekly notification channel id',
              'weekly notification channel name',
              'weekly notificationdescription'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        payload: "schedule every :" +
            indexToDay[schedule.weekday] +
            schedule.hour.toString() +
            ":" +
            schedule.minute.toString());
  }
}

Future<void> NextHourAndMin(
    int hour, int min, String title, String body) async {
  tz.TZDateTime schedule = nextInstanceOfanytime(hour, min);
  await flutterLocalNotificationsPlugin.zonedSchedule(
    schedule.hashCode,
    '${title}',
    '${body}',
    schedule,
    const NotificationDetails(
      android: AndroidNotificationDetails(
          'NextHourMin notification channel id',
          'NextHourMin notification channel name',
          'NextHourMin notification description'),
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

tz.TZDateTime _getDatebyDayList(List day, tz.TZDateTime schedule) {
  if (day[0] == true) {
    while (schedule.weekday != DateTime.monday) {
      schedule = schedule.add(const Duration(days: 1));
    }
    day[0] = false;
    return schedule;
  }
  if (day[1] == true) {
    while (schedule.weekday != DateTime.tuesday) {
      schedule = schedule.add(const Duration(days: 1));
    }
    day[1] = false;
    return schedule;
  }
  if (day[2] == true) {
    while (schedule.weekday != DateTime.wednesday) {
      schedule = schedule.add(const Duration(days: 1));
    }
    day[2] = false;
    return schedule;
  }
  if (day[3] == true) {
    while (schedule.weekday != DateTime.thursday) {
      schedule = schedule.add(const Duration(days: 1));
    }
    day[3] = false;
    return schedule;
  }
  if (day[4] == true) {
    while (schedule.weekday != DateTime.friday) {
      schedule = schedule.add(const Duration(days: 1));
    }
    day[4] = false;
    return schedule;
  }
  if (day[5] == true) {
    while (schedule.weekday != DateTime.saturday) {
      schedule = schedule.add(const Duration(days: 1));
    }
    day[5] = false;
    return schedule;
  }
  if (day[6] == true) {
    while (schedule.weekday != DateTime.sunday) {
      schedule = schedule.add(const Duration(days: 1));
    }
    day[6] = false;
    return schedule;
  }
  return null;
}

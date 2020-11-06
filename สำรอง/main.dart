import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await tz.initializeTimeZones();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          onDidReceiveLocalNotification:
              (int id, String title, String body, String payload) async {
            print("ondidReceiveIOS");
          });
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            FlatButton(
              onPressed: () async {
                final String currentTimeZone =
                    await FlutterNativeTimezone.getLocalTimezone();
                await flutterLocalNotificationsPlugin.zonedSchedule(
                    0,
                    'aRaimaiRu',
                    'F9 => "?"',
                    tz.TZDateTime.now(tz.getLocation(currentTimeZone))
                        .add(const Duration(seconds: 5)),
                    const NotificationDetails(
                        android: AndroidNotificationDetails(
                            'full screen channel id',
                            'full screen channel name',
                            'full screen channel description',
                            priority: Priority.high,
                            importance: Importance.high,
                            fullScreenIntent: true)),
                    androidAllowWhileIdle: true,
                    uiLocalNotificationDateInterpretation:
                        UILocalNotificationDateInterpretation.absoluteTime);

                // Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
            FlatButton(
              onPressed: () {
                // _showOngoingNotification();
                // print(DateTime.monday);1
                // print(DateTime.tuesday);2
                // print(DateTime.wednesday);3
                // print(DateTime.thursday);4
                // print(DateTime.friday);5
                // print(DateTime.saturday);6
                // print(DateTime.sunday);7
              },
              child: const Text('Friday0am'),
            ),
            FlatButton(
              onPressed: () async {
                await _scheduleWeeklyAnyDayTimeNotification();
                final List<PendingNotificationRequest>
                    pendingNotificationRequests =
                    await flutterLocalNotificationsPlugin
                        .pendingNotificationRequests();
                final List<ActiveNotification> activeNotifications =
                    await flutterLocalNotificationsPlugin
                        .resolvePlatformSpecificImplementation<
                            AndroidFlutterLocalNotificationsPlugin>()
                        ?.getActiveNotifications();
                print(activeNotifications.length);
                print(
                    "pendingNotificationRequests ${pendingNotificationRequests.first.id}");
                // print(DateTime.monday);1
                // print(DateTime.tuesday);2
                // print(DateTime.wednesday);3
                // print(DateTime.thursday);4
                // print(DateTime.friday);5
                // print(DateTime.saturday);6
                // print(DateTime.sunday);7
              },
              child: const Text('pendingNoti'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//showongoingNoti
Future<void> _showOngoingNotification() async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'your channel id', 'your channel name', 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ongoing: true,
          autoCancel: false);
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(0, 'ongoing notification title',
      'ongoing notification body', platformChannelSpecifics);
}
//   Future<Widget> _getActiveNotificationsDialogContent() async {
//     final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     if (!(androidInfo.version.sdkInt >= 23)) {
//       return const Text(
//         '"getActiveNotifications" is available only for Android 6.0 or newer',
//       );
//     }
//  Future<void> _getActiveNotifications() async {
//     final Widget activeNotificationsDialogContent =
//         await _getActiveNotificationsDialogContent();
//     await showDialog<void>(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         content: activeNotificationsDialogContent,
//         actions: <Widget>[
//           FlatButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

// //check all pending noti
// Future<void> _checkPendingNotificationRequests() async {
//   final List<PendingNotificationRequest> pendingNotificationRequests =
//       await flutterLocalNotificationsPlugin.pendingNotificationRequests();
//   print(
//       "flutterLocalNotificationsPlugin = ${pendingNotificationRequests.first} ");
// }

Future<void> _scheduleWeeklyAnyDayTimeNotification() async {
  final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  tz.TZDateTime time = _nextInstanceDayAndHour(5, 0, currentTimeZone);
  String stime = time.toString();
  String mytime = stime.splitMapJoin((new RegExp('[0-9]')),
      onMatch: (m) => '${m.group(0)}', onNonMatch: (n) => '*'); // *shoots*
  //String myid = stime.substring(0, 4) + stime.substring(5, 7)+stime.substring(startIndex);
  print("time = $mytime");
  await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'weekly scheduled notification title',
      'weekly scheduled notification body',
      _nextInstanceDayAndHour(5, 0, currentTimeZone),
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

//Any day and hour
tz.TZDateTime _nextInstanceDayAndHour(int day, int hour, String local) {
  tz.TZDateTime scheduledDate = _nextInstanceOfanytime(hour, local);
  while (scheduledDate.weekday != day) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  scheduledDate = scheduledDate.add(Duration(minutes: 18));
  print("scheduledDate = $scheduledDate");
  return scheduledDate;
}

//any time
tz.TZDateTime _nextInstanceOfanytime(int hour, String local) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.getLocation(local));
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, hour);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

class ABC extends StatefulWidget {
  @override
  _ABCState createState() => _ABCState();
}

class _ABCState extends State<ABC> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

//show pending noti
Future<void> checkPendingNotificationRequests(context) async {
  final List<PendingNotificationRequest> pendingNotificationRequests =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: setupAlertDialog(pendingNotificationRequests),
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

class setupAlertDialog extends StatefulWidget {
  List initialist;
  setupAlertDialog(this.initialist);
  @override
  _setupAlertDialogState createState() => _setupAlertDialogState();
}

class _setupAlertDialogState extends State<setupAlertDialog> {
  @override
  Widget build(BuildContext context) {
    List mylist = widget.initialist;
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.initialist.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("${mylist[index].title}"),
            subtitle: Text("${mylist[index].payload}"),
            trailing: IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () async {
                print("Remove id = ${mylist[index].id}");
                await flutterLocalNotificationsPlugin.cancel(mylist[index].id);
                await mylist.removeAt(index);
                setState(() {});
              },
            ),
          );
        },
      ),
    );
  }
}

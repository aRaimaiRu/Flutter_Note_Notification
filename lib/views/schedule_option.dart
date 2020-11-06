import 'package:flutter/material.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:intl/intl.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

final ckey = new GlobalKey<ComplexDateTimeFieldState>();

class Notfication_optionlist extends StatefulWidget {
  Notfication_optionlist({Key key}) : super(key: key);

  @override
  Notfication_optionlistState createState() => Notfication_optionlistState();
}

class Notfication_optionlistState extends State<Notfication_optionlist> {
  // final _formKey = GlobalKey<FormState>();
  DateTime initialValue = DateTime.now();
  DateTime get timevalue => initialValue;

  Widget my_widget() {
    return new TimePickerSpinner(
      is24HourMode: true,
      normalTextStyle: TextStyle(fontSize: 24, color: Colors.deepOrange),
      highlightedTextStyle: TextStyle(fontSize: 24, color: Colors.yellow),
      spacing: 50,
      itemHeight: 80,
      isForce2Digits: true,
      onTimeChange: (time) {
        setState(() {
          initialValue = time;
        });
        print(initialValue);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          Container(child: my_widget()),
          ComplexDateTimeField(
            ckey: ckey,
          ),
        ],
      ),
    );
  }
}

class ComplexDateTimeField extends StatefulWidget {
  ComplexDateTimeField({Key ckey}) : super(key: ckey);
  @override
  ComplexDateTimeFieldState createState() => ComplexDateTimeFieldState();
}

class ComplexDateTimeFieldState extends State<ComplexDateTimeField> {
  DateTime initialValue = DateTime.now();

  List dayList = [false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      CheckboxListTile(
        title: Text('Monday'),
        value: dayList[0],
        onChanged: (value) {
          setState(() => dayList[0] = value);
        },
      ),
      CheckboxListTile(
        title: Text('Tuesday'),
        value: dayList[1],
        onChanged: (value) {
          setState(() => dayList[1] = value);
        },
      ),
      CheckboxListTile(
        title: Text('Wednesday'),
        value: dayList[2],
        onChanged: (value) {
          setState(() => dayList[2] = value);
        },
      ),
      CheckboxListTile(
        title: Text('Thrusday'),
        value: dayList[3],
        onChanged: (value) {
          setState(() => dayList[3] = value);
        },
      ),
      CheckboxListTile(
        title: Text('Friday'),
        value: dayList[4],
        onChanged: (value) {
          setState(() => dayList[4] = value);
        },
      ),
      CheckboxListTile(
        title: Text('Saturday'),
        value: dayList[5],
        onChanged: (value) {
          setState(() => dayList[5] = value);
        },
      ),
      CheckboxListTile(
        title: Text('Sunday'),
        value: dayList[6],
        onChanged: (value) {
          setState(() => dayList[6] = value);
        },
      ),
    ]);
  }
}

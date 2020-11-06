import 'package:flutter/material.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:intl/intl.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

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
          ComplexDateTimeField(),
        ],
      ),
    );
  }
}

class ComplexDateTimeField extends StatefulWidget {
  @override
  _ComplexDateTimeFieldState createState() => _ComplexDateTimeFieldState();
}

class _ComplexDateTimeFieldState extends State<ComplexDateTimeField> {
  DateTime initialValue = DateTime.now();

  bool isSun = false;
  bool isMon = false;
  bool isTue = false;
  bool isWed = false;
  bool isThr = false;
  bool isFri = false;
  bool isSat = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      CheckboxListTile(
        title: Text('Sunday'),
        value: isSun,
        onChanged: (value) {
          setState(() => isSun = value);
        },
      ),
      CheckboxListTile(
        title: Text('Monday'),
        value: isMon,
        onChanged: (value) {
          setState(() => isMon = value);
        },
      ),
      CheckboxListTile(
        title: Text('Tuesday'),
        value: isTue,
        onChanged: (value) {
          setState(() => isTue = value);
        },
      ),
      CheckboxListTile(
        title: Text('Wednesday'),
        value: isWed,
        onChanged: (value) {
          setState(() => isWed = value);
        },
      ),
      CheckboxListTile(
        title: Text('Thrusday'),
        value: isThr,
        onChanged: (value) {
          setState(() => isThr = value);
        },
      ),
      CheckboxListTile(
        title: Text('Friday'),
        value: isFri,
        onChanged: (value) {
          setState(() => isFri = value);
        },
      ),
      CheckboxListTile(
        title: Text('Saturday'),
        value: isSat,
        onChanged: (value) {
          setState(() => isSat = value);
        },
      ),
    ]);
  }
}

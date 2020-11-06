import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

// final ckey = new GlobalKey<ComplexDateTimeFieldState>();

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
      normalTextStyle: TextStyle(fontSize: 24, color: Colors.grey),
      highlightedTextStyle: TextStyle(fontSize: 24, color: Colors.blueAccent),
      spacing: 25,
      itemHeight: 50,
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
    return Container(child: my_widget());
  }
}


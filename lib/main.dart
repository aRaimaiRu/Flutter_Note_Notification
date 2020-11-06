import 'package:flutter/material.dart';
import 'package:simplenoti/views/note_list.dart';
import 'package:simplenoti/inherited_widget/note_inherited_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NoteInheritedWidget(
      child: MaterialApp(
        title: 'Notes',
        home: NoteList(),
      ),
    );
  }
}

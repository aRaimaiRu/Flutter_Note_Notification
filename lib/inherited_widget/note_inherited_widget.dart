import 'package:flutter/material.dart';

class NoteInheritedWidget extends InheritedWidget {
  NoteInheritedWidget({Widget child}) : super(child: child);

  var notes = [
    {'title': 'someTitle', 'text': 'someText'},
    {
      'title':
          'someTitlesomeTitlesomeTitlesomeTitlesomeTitlesomeTitlesomeTitle',
      'text':
          'someTextsomeTextsomeTextsomeTextsomeTextsomeTextsomeTextsomeTextsomeText'
    },
    {'title': 'someTitlesomeTitle', 'text': 'someTextsomeText'},
  ];

  static NoteInheritedWidget of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<NoteInheritedWidget>());
  }

  @override
  bool updateShouldNotify(NoteInheritedWidget oldWidget) {
    //print("this is inherited $notes");
    return oldWidget.notes != notes;
  }
}

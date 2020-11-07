import 'package:flutter/material.dart';
import 'package:simplenoti/provider/provider.dart';
import 'schedule_option.dart';
import 'package:simplenoti/Localnotification/Localnotification.dart';

enum NoteMode { Editing, Adding }
final key = new GlobalKey<Notfication_optionlistState>();

class Note extends StatefulWidget {
  final NoteMode noteMode;
  final Map<String, dynamic> note;

  Note(this.noteMode, this.note);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  List myday = [false, false, false, false, false, false, false];
  bool onetime = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (widget.noteMode == NoteMode.Editing) {
      _titleController.text = widget.note['title'];
      _textController.text = widget.note['text'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> displayList = [];
    //Size size = MediaQuery.of(context).size;
    for (int i = 0; i < myday.length; i++) {
      displayList.add(FlatButton(
        color: myday[i] ? Colors.blueAccent : Colors.grey,
        onPressed: () {
          setState(() {
            myday[i] = !myday[i];
          });
        },
        child: Text("${indexToDay[i + 1]}"),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.noteMode == NoteMode.Adding ? "Add note" : "Edit note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Notfication_optionlist(
              key: key,
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Note title'),
            ),
            Container(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              controller: _textController,
              decoration: InputDecoration(hintText: 'Note text'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _NoteButton("Save", Colors.amberAccent, () async {
                  final title = _titleController.text;
                  final text = _textController.text;
                  int hour = key.currentState.timevalue.hour;
                  int min = key.currentState.timevalue.minute;

                  if (myday.contains(true)) {
                    scheduleWeeklyAnyDayTimeNotification(
                        myday, hour, min, title, text);
                  }
                  if (onetime) {
                    NextHourAndMin(hour, min, title, text);
                  }
                  if (widget.noteMode == NoteMode.Adding) {
                    NoteProvider.insertNote({'title': title, 'text': text});
                  } else if (widget.noteMode == NoteMode.Editing) {
                    NoteProvider.updateNote({
                      'id': widget.note['id'],
                      'title': _titleController.text,
                      'text': _textController.text
                    });
                  }

                  Navigator.pop(context);
                }),
                _NoteButton("Discard", Colors.grey, () {
                  _textController.clear();
                  _titleController.clear();
                }),
                _NoteButton("Delete", Colors.redAccent, () {
                  NoteProvider.deleteNote(widget.note['id']);
                  Navigator.pop(context);
                }),
              ],
            ),
            Text("Notfication"),
            FlatButton(
              color: onetime ? Colors.blueAccent : Colors.grey,
              onPressed: () {
                setState(() {
                  onetime = !onetime;
                });
              },
              child: Text("Next Time"),
            ),
            FlatButton(
              color: onetime ? Colors.blueAccent : Colors.grey,
              onPressed: () {
                setState(() {
                  onetime = !onetime;
                });
              },
              child: Text("Next Time"),
            ),
            Wrap(
              children: displayList,
            ),
          ],
        ),
      ),
    );
  }
}

class _NoteButton extends StatelessWidget {
  final String _text;
  final Color _color;
  final Function _onPressed;

  _NoteButton(this._text, this._color, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _onPressed,
      child: Text(_text),
      color: _color,
    );
  }
}

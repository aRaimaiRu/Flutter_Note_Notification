import 'package:flutter/material.dart';
// import 'package:simplenoti/inherited_widget/note_inherited_widget.dart';
import 'package:simplenoti/provider/provider.dart';
import 'note.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  // List<Map<String, String>> get _notes => NoteInheritedWidget.of(context).notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: FutureBuilder<Object>(
          future: NoteProvider.getNoteList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final List notes = snapshot.data;

              return ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Note(NoteMode.Editing, notes[index])));
                      setState(() {});
                    },
                    child: Mycard(
                      text: notes[index]['text'],
                      title: notes[index]['title'],
                    ),
                  );
                },
                itemCount: notes.length,
              );
            } //end if
            return Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Note(NoteMode.Adding, null)));
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Mycard extends StatefulWidget {
  final String title;
  final String text;

  const Mycard({Key key, this.title, this.text}) : super(key: key);

  @override
  _MycardState createState() => _MycardState();
}

class _MycardState extends State<Mycard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.title}",
              style: TextStyle(fontSize: 25),
            ),
            Text(
              "${widget.text}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

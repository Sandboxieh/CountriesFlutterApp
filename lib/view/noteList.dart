import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:countries_interview_application/controller/noteController.dart';
import 'package:countries_interview_application/model/noteModel.dart';
import 'package:countries_interview_application/view/addNote.dart';
import 'package:countries_interview_application/view/updateNote.dart';

class NoteScreen extends StatefulWidget {
  final dynamic countryid;
  NoteScreen({Key key, this.countryid}) : super(key: key);
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen>
    with AutomaticKeepAliveClientMixin {
  List<Note> notes = [];
  bool loading = true;

  getNotes() {
    notes.clear();
    setState(() {
      loading = true;
    });
    NoteController().getNoteById(widget.countryid).then((value) {
      value.forEach((element) {
        notes.add(Note.fromMap(element));
      });
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : notes.isEmpty
              ? Center(child: Text("No notes available"))
              : ListView.builder(
                  itemCount: notes.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: ObjectKey(notes[index].id),
                      background: stackBehindDismiss(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) async {
                        await NoteController().deleteNote(notes[index].id);
                        notes.removeAt(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5),
                        child: _buildCardItems(notes[index], context),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Feather.plus),
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddNotesScreen(countryid: widget.countryid)))
              .then((value) => getNotes());
        },
      ),
    );
  }

  Widget _buildCardItems(Note note, context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                UpdateNoteScreen(note: note, countryid: widget.countryid),
          ),
        ).then((value) => getNotes());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  note.title,
                  style: TextStyle(fontWeight: FontWeight.w600),
                  maxLines: 1,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  note.content,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

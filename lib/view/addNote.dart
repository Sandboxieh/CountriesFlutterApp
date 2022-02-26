import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:countries_interview_application/controller/noteController.dart';
import 'package:countries_interview_application/model/noteModel.dart';

class AddNotesScreen extends StatefulWidget {
  final title;
  final dynamic countryid;
  const AddNotesScreen({Key key, this.title, this.countryid}) : super(key: key);

  @override
  _AddNotesScreenState createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  TextEditingController _title = TextEditingController();
  TextEditingController _content = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  saveNote() {
    if (_formKey.currentState.validate()) {
      NoteController()
          .saveNote(
            Note("${_title.text}", "${_content.text}", "${widget.countryid}"),
          )
          .then((value) => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          title: Text(
            'Add a Note',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Feather.save),
                key: Key('save'),
                onPressed: () {
                  saveNote();
                }),
          ],
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height - 20,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: TextFormField(
                            key: Key('title'),
                            controller: _title,
                            validator: NoteController.validateTitle,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration.collapsed(
                              hintText: 'Note Title',
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.3,
                        ),
                      ),
                      Expanded(
                          child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              key: Key('content'),
                              controller: _content,
                              validator: NoteController.validateContent,
                              maxLines: null,
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Type your note here...'),
                              textCapitalization: TextCapitalization.sentences,
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        )));
  }
}

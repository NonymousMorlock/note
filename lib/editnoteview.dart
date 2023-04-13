import 'package:flutter/material.dart';
import 'package:note/model/note_model.dart';

class EditNoteView extends StatefulWidget {
  const EditNoteView({super.key, required this.note});

  final NoteModel note;

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  late String newTitle;
  late String newNoteContent;

  @override
  void initState() {
    debugPrint('EditNoteView: initState() called');
    super.initState();
    newTitle = widget.note.title.toString();
    newNoteContent = widget.note.content.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
              splashRadius: 17,
              onPressed: () async {
                NoteModel newNote = myNotes(
                    content: newNoteContent,
                    title: newTitle,
                    createdTime: DateTime.now(),
                    id: widget.note.ref!.id);
                var NotesDatabase;
                await NotesDatabase.instance.updateNote(newNote);

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => viewnote(
                              note: newNote,
                            )));
              },
              icon: Icon(Icons.save_outlined))
        ],
      ),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Form(
                child: TextFormField(
                  initialValue: "NewTitle",
                  cursorColor: Colors.white,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.withOpacity(0.8))),
                ),
              ),
              Container(
                height: 300,
                child: Form(
                  child: TextFormField(
                    onChanged: (value) {
                      newNoteContent = value;
                    },
                    initialValue: "NewNoteDet",
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.multiline,
                    minLines: 50,
                    maxLines: 50,
                    style: TextStyle(fontSize: 17, color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        //   disabledBorder: Inputborder.none,
                        hintText: "Notes",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.withOpacity(0.8))),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  viewnote({required NoteModel note}) {}

  myNotes(
      {required String content,
      required DateTime createdTime,
      required id,
      required String title}) {}
}

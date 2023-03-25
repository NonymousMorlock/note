import 'package:flutter/material.dart';
import 'model/mynotemodel.dart';

class Editnoteview extends StatefulWidget {
 var myNotes;
 var note;


  Editnoteview({required this.note});

  @override
  _EditnoteviewState createState() => _EditnoteviewState();
}
class _EditnoteviewState extends State<Editnoteview> {
  late String NewTitle;
  late String NewNoteDet;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.NewTitle = widget.note.title.toString();
    this.NewNoteDet = widget.note.content.toString();
  }

  Widget build(BuildContext context) {
    var bgColor;
    var Inputborder;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
              splashRadius: 17,
              onPressed: () async {
                MyNoteModel newNote = myNotes(
                    content: NewNoteDet,
                    title: NewTitle,
                    createdTime: DateTime.now(),
                    id: widget.note.id );
                var NotesDatabase;
                await NotesDatabase.instance.updateNote(newNote);

                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) =>
                    viewnote(note: newNote,)));
              },
              icon: Icon(Icons.save_outlined))
        ],
      ),
      body:
      Container(
          margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10
          ),
          child: Column(
            children: [
              Form(
                child:
                TextFormField(
                  initialValue: "NewTitle",
                  cursorColor: Colors.white,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white),
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
                      NewNoteDet = value;
                    },
                    initialValue: "NewNoteDet",
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.multiline,
                    minLines: 50,
                    maxLines: 50,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                     //   disabledBorder: Inputborder.none,
                        hintText: "Notes",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.withOpacity(0.8)
                        )
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

  viewnote({required MyNoteModel note}) {}

  myNotes(
      {required String content, required DateTime createdTime, required id, required String title}) {}

}










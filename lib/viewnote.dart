import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note/login.dart';

class ViewNote extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  const ViewNote(this.data, this.time, this.ref, {super.key});

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  late String title;
  late String des;

  bool edit = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  get isEmpty => null;

  @override
  Widget build(BuildContext context) {
    title = widget.data['title'];
    des = widget.data['description'];

    return SafeArea(
      child: Scaffold(
        //
        floatingActionButton: FloatingActionButton(
          onPressed: edit
              ? save
              : () async {
                  await GoogleSignIn().signOut();
                  await FirebaseAuth.instance.signOut();
                  if (!mounted) return;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false);
                },
          backgroundColor: Colors.grey[700],
          child: Icon(
            edit ? Icons.save_rounded : Icons.logout,
            color: Colors.white70,
          ),
        ),
        //
        //
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(
              12.0,
            ),
            child: Form(
              key: key,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.grey[700],
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              horizontal: 25.0,
                              vertical: 8.0,
                            ),
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_outlined,
                          size: 24.0,
                        ),
                      ),

                      //

                      ElevatedButton(
                        onPressed: delete,

                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.grey[300],
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              horizontal: 25.0,
                              vertical: 8.0,
                            ),
                          ),
                        ),
                        child: const Icon(
                          Icons.delete_forever,
                          size: 24.0,
                        ), //
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            edit = true;
                          });
                        },

                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.grey[700],
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              horizontal: 25.0,
                              vertical: 8.0,
                            ),
                          ),
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 24.0,
                        ), //
                      ),
                    ],
                  ),
                  //
                  const SizedBox(
                    height: 12.0,
                  ),
                  //
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: TextFormField(
                            decoration: const InputDecoration.collapsed(
                              hintText: "title",
                            ),
                            style: const TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                            initialValue: widget.data['title'],
                            enabled: edit,
                            onChanged: (val) {
                              title = val;
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Can't be empty !";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 12.0,
                            bottom: 12.0,
                          ),
                          child: Text(
                            widget.time,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      decoration: const InputDecoration.collapsed(
                        hintText: "Note Description",
                      ),
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey,
                      ),
                      initialValue: widget.data['description'],
                      enabled: edit,
                      onChanged: (val) {
                        des = val;
                      },
                      // maxLines: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void delete() async {
    // delete from db
    await widget.ref.delete();
    if (!mounted) return;
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.pop(context);
  }

  void save() async {
    // if (key.currentState?.validate()) {
    // TODO : showing any kind of alert that new changes have been saved.
    await widget.ref.update(
      {'title': title, 'description': des, 'updated': DateTime.now()},
    );
    if (!mounted) return;
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(context).pop();
  }
}

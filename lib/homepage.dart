import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note/addnote.dart';
import 'package:note/model/note_model.dart';

import 'viewnote.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('notes');

  //List<Color> myColors = [
  // Colors.yellow[200]!,
  //  Colors.red[200]!,
  // Colors.green[200]!,
  // Colors.deepPurple[200]!,
  // ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 200,
              child: FutureBuilder<QuerySnapshot>(
                future: ref.get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final dataList = snapshot.data?.docs.map((doc) {
                      final documentData = doc.data() as Map<String, dynamic>;
                      documentData['ref'] = doc.reference;
                      return NoteModel.fromJson(documentData);
                    }).toList()?..sort((a, b) {
                        return (b.createdTime as Timestamp)
                            .compareTo(a.createdTime as Timestamp);
                      });
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Wrap(
                          spacing: 13,
                          runSpacing: 13,
                          alignment: WrapAlignment.center,
                          children: List.generate(dataList!.length,
                              (index) {
                            Color bg = Colors.purple;
                            NoteModel data = dataList[index];
                            DateTime myDateTime = data.createdTime!.toDate();
                            DateTime lastEditDate = data.updatedTime!.toDate();

                            String formattedTime =
                                DateFormat.yMMMd().add_jm().format(myDateTime);
                            return InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) => ViewNote(
                                      note: data,
                                      time: formattedTime,
                                    ),
                                  ),
                                )
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              child: Container(
                                width: (size.width / 2) - 30,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: (Alignment.centerRight),
                                          child: Text(
                                            'created on ${DateFormat.yMMMd()
                                                .add_jm()
                                                .format(myDateTime)}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: (Alignment.centerRight),
                                          child: Text(
                                            'last edited on ${DateFormat.yMMMd()
                                                .add_jm()
                                                .format(lastEditDate)}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${data.title}",
                                          style: const TextStyle(
                                            fontSize: 32.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            );
                          })),
                    );
                  } else {
                    return const Center(
                      child: Text("Loading...",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 300,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: const Text('Save'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => const AddNote(),
            ),
          )
              .then((_) {
            setState(() {});
          });
        },
        backgroundColor: (Colors.grey[700]),
        child: const Icon(
          Icons.add,
          color: Colors.white70,
        ),
      ),
    );
  }
}

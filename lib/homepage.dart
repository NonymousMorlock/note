import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note/addnote.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Expanded(
            //   flex: 15,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Container(
            //           color: Colors.red,
            //           margin: const EdgeInsets.all(10),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.stretch,
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               const SizedBox(),
            //               ElevatedButton(
            //                 child: const Text('Save'),
            //                 onPressed: () {},
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         flex: 10,
            //         child: Container(),
            //       )
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 200,
              child: FutureBuilder<QuerySnapshot>(
                future: ref.get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          Color bg = Colors.purple;
                          Map data = snapshot.data?.docs[index].data() as Map;
                          DateTime myDateTime = (data['created']).toDate();

                          String formattedTime =
                              DateFormat.yMMMd().add_jm().format(myDateTime);
                          return InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(
                                MaterialPageRoute(
                                  builder: (context) => ViewNote(
                                    data,
                                    formattedTime,
                                    snapshot.data!.docs[index].reference,
                                  ),
                                ),
                              )
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            child: Card(
                              color: bg,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data['title']}",
                                        style: const TextStyle(
                                          fontSize: 32.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),

                                      //
                                      Container(
                                        alignment: (Alignment.centerRight),
                                        child: Text(
                                          DateFormat.yMMMd()
                                              .add_jm()
                                              .format(myDateTime),
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          );
                        });
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

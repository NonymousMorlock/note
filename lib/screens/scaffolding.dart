import 'package:flutter/material.dart';
import 'package:note/addnote.dart';
import 'package:note/homepage.dart';

class Scaffolding extends StatefulWidget {
  const Scaffolding({super.key});

  @override
  State<Scaffolding> createState() => _ScaffoldingState();
}

class _ScaffoldingState extends State<Scaffolding> {
  int _selectedIndex = 0;

  final screens = <Widget>[
    const HomePage(),
    const Placeholder(),
    const Placeholder(),
    const AddNote(),
    // SearchPage(),
    // NotificationsPage(),
    // AddNotesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => const AddNote(),
            ),
          )
              .then((value) {
            debugPrint("Calling Set State !");
            setState(() {});
          });
        },
        backgroundColor: (Colors.grey[700]),
        child: const Icon(
          Icons.add,
          color: Colors.white70,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          elevation: 0,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Notes',
              backgroundColor: Colors.transparent,
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: 'Add Notes',
            ),
          ],
          onTap: (index) => setState(() => _selectedIndex = index)),
    );
  }
}

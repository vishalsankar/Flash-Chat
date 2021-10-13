import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flashchat_new/screens/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';


FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ChatDrawer extends StatefulWidget {

  List<Color> userColors=[
    Colors.pink,
    Colors.red,
    Colors.deepPurple,
    Colors.black54,
    Colors.orange
  ];

  List<String> usernames = [];
  User? loggedInUser = _auth.currentUser;
  ChatDrawer({required this.usernames});
  @override
  _ChatDrawerState createState() => _ChatDrawerState();
}

class _ChatDrawerState extends State<ChatDrawer> {
  List<TextButton> users = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDrawerItems();
  }

  void getDrawerItems() async {
    final emails = await _firestore.collection('users').get();
    final emaildocs = emails.docs;
    if (emaildocs.isNotEmpty) {
      for (var email in emaildocs) {
        if (email['email'] == loggedInUser.email.toString()) {
          continue;
        } else {
          setState(() {
            users.add(TextButton(
              onPressed: () {},
              child: Text('${email['email']}'),
            ));
          });
          continue;
        }
      }
    } else {
      print('nothing to show');
    }
  }

  // Widget getDrawerItems(){
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: _firestore.collection('users').snapshots(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) {
  //         return Expanded(
  //           child: Container(
  //             color: Colors.white,
  //           ),
  //         );
  //       } else {
  //         final useremails = snapshot.data!.docs;
  //         for (var emails in useremails) {
  //           users.add(
  //             TextButton(
  //               onPressed: () {},
  //               child: Text(emails['email']),
  //             ),
  //           );
  //         }
  //       }
  //       return Expanded(
  //         child: ListView(children: users),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.lightBlueAccent,
            ),
            accountName: const Text('You'),
            accountEmail: Text(loggedInUser.email.toString()),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text(loggedInUser.email.toString()[0],
                  style: TextStyle(fontSize: 50.0)),
            ),
          ),
          Column(
            children: users,
          )
        ],
      ),
    );
  }
}


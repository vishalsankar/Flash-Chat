import 'package:flutter/material.dart';
import 'message_bubbles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


FirebaseAuth _auth=FirebaseAuth.instance;
FirebaseFirestore _firestore=FirebaseFirestore.instance;
User? loggedInUser=_auth.currentUser;

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection("${loggedInUser!.email.toString()}")
          .orderBy('timestamp', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        try {
          if (!snapshot.hasData) {
            Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          final messages = snapshot.data!.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message['text'];
            final messageSender = message['sender'];
            final currentUser = loggedInUser!.email.toString() + '.';
            final messageBubble = MessageBubble(
              text: messageText,
              sender: messageSender,
              isMe: currentUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
              children: messageBubbles,
            ),
          );
        } catch (e) {
          return Text(
            'Please wait patiently till the Page loads',
            style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
}
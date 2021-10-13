import 'chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flashchat_new/widgets/rounded_button.dart';
import 'login_page.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flashchat_new/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationPage extends StatefulWidget {
  static String id = 'registration_id';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late ProgressHUD progressHUD;
  late String email;
  late String password;

  void addUserEmailInCollection(String email) {
    _firestore.collection('users').add({
      'email': email,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ProgressHUD(
        child: Builder(
          builder: (context) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 200.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your email')),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                      textAlign: TextAlign.center,
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter a password')),
                  SizedBox(
                    height: 8.0,
                  ),
                  RoundedButton(
                    buttoncolor: Colors.blueAccent,
                    buttontitle: 'Register',
                    onpressed: () async {
                      final progress = ProgressHUD.of(context);
                      progress!.show();
                      Future.delayed(Duration(seconds: 4), () {
                        progress.dismiss();
                      });
                      try {
                        final newuser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newuser != null) {
                          addUserEmailInCollection(email);
                          Navigator.pushNamed(context, ChatPage.id);
                        }
                      } catch (e) {
                        return showDialog(context: context, builder: (context){
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Text(
                              'Alert',
                              style: TextStyle(fontSize: 20.0, color: Colors.black),
                            ),
                            content: Text(e.toString()),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Go Back to Registration Screen?'),
                              )
                            ],
                            elevation: 24.0,
                          );
                        });
                      }
                    },
                  ),
                  RoundedButton(
                    buttoncolor: Colors.lightBlueAccent,
                    buttontitle: 'Go to Login Page',
                    onpressed: () {
                      Navigator.pushNamed(context, LoginPage.id);
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flashchat_new/constants/constants.dart';
import 'chat_page.dart';
import 'registration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat_new/widgets/rounded_button.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';


class LoginPage extends StatefulWidget {
  static String id = 'login_id';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // late final FocusNode focusnode;
  late String email;
  late String password;
  bool showSpinner = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ProgressHUD(
        child: Builder(
          builder: (context) => Padding(
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
                        hintText: 'Enter your email or username')),
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
                      hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  buttoncolor: Colors.lightBlueAccent,
                  buttontitle: 'Log in',
                  onpressed: () async {
                    final progress = ProgressHUD.of(context);
                    progress!.show();
                    Future.delayed(Duration(seconds: 4), () {
                      progress.dismiss();
                    });
                    try {
                      final userlogin = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (userlogin != null) {
                        Navigator.pushNamed(context, ChatPage.id);
                      }
                      progress.dismiss();
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
                                child: Text('Go Back to Login Screen?'),
                              )
                            ],
                            elevation: 24.0,
                          );
                      });
                    }
                  },
                ),
                RoundedButton(
                  buttoncolor: Colors.blueAccent,
                  buttontitle: 'Go to Registeration page',
                  onpressed: () {
                    Navigator.pushNamed(context, RegistrationPage.id);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

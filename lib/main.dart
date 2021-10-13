import 'package:flutter/material.dart';
import 'package:flashchat_new/screens/welcome_page.dart';
import 'package:flashchat_new/screens/chat_page.dart';
import 'package:flashchat_new/screens/login_page.dart';
import 'package:flashchat_new/screens/registration_page.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomePage.id,
      routes: {
        WelcomePage.id:(context)=>WelcomePage(),
        RegistrationPage.id:(context)=>RegistrationPage(),
        LoginPage.id:(context)=>LoginPage(),
        ChatPage.id:(context)=>ChatPage(),
      },
    );
  }
}
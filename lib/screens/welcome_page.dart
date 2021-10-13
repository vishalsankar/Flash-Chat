import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'registration_page.dart';
import 'login_page.dart';
import 'package:flashchat_new/widgets/rounded_button.dart';


class WelcomePage extends StatefulWidget {
  static String id='welcome_id';

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 60.0,
                    ),
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      textStyle: TextStyle(
                          fontSize: 45.0, fontWeight: FontWeight.w900, color: Colors.black),
                      speed: Duration(milliseconds: 200),

                    )
                  ],
                  totalRepeatCount: 3,
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(buttoncolor: Colors.lightBlueAccent,buttontitle: 'Log in',onpressed: (){Navigator.pushNamed(context, LoginPage.id);},),
            RoundedButton(buttoncolor: Colors.blueAccent,buttontitle: 'Register',onpressed: (){Navigator.pushNamed(context, RegistrationPage.id);},)
          ],
        ),
      ),
    );
  }
}

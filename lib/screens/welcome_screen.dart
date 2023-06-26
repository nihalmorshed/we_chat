import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/auth/login_screen.dart';
import 'package:we_chat/screens/welcome_secondary.dart';
import 'package:we_chat/auth/reg_screen.dart';
import 'package:we_chat/widgets/padding_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(
        seconds: 5,
      ),
      vsync: this,
    );
    animation = ColorTween(
      begin: Colors.white,
      end: Colors.red,
    ).animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {});
      print(animation.value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset('images/logo.png'),
                  height: 60,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flash Chat',
                      textStyle: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w900,
                      ),
                      speed: Duration(
                        milliseconds: 70,
                      ),
                    )
                  ],
                  repeatForever: true,
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            PaddingButton(
              text: 'Log-In',
              colr: Colors.lightBlueAccent,
              func: () {
                Navigator.pushNamed(context, WelcomeSecondary.id);
              },
            ),
            PaddingButton(
              text: 'Register',
              colr: Colors.blueAccent,
              func: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

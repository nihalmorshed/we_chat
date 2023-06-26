import 'package:flutter/material.dart';
import 'package:we_chat/screens/welcome_secondary.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);
  static const String id = 'splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      setState(() {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return WelcomeSecondary();
        }));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .15,
            right: mq.width * .25,
            width: mq.width * .5,
            child: Image.asset("images/logo.png"),
          ),
          Positioned(
            bottom: mq.height * .15,
            left: mq.width * .25,
            width: mq.width * .5,
            child: const Text(
              "Flash Chat!!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

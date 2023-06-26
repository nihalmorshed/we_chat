import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/auth/api.dart';
import 'package:we_chat/auth/login_screen.dart';
import 'package:we_chat/auth/reg_screen.dart';
import 'package:we_chat/constants.dart';
import 'package:we_chat/screens/home_screen.dart';
import 'package:we_chat/widgets/google_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_chat/widgets/snackbar.dart';

class WelcomeSecondary extends StatefulWidget {
  WelcomeSecondary({Key? key}) : super(key: key);
  static const String id = 'login-secondary';

  @override
  State<WelcomeSecondary> createState() => _WelcomeSecondaryState();
}

class _WelcomeSecondaryState extends State<WelcomeSecondary> {
  bool is_animate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        is_animate = true;
      });
    });
  }

  _handleGooglebtnclick() async {
    SnackbarWidget.showProgressIndicator(context);
    try {
      await signInWithGoogle().then((value) async {
        Navigator.pop(context);
        if (value != null) {
          if ((await API.userExists())) {
            Navigator.pushReplacementNamed(context, HomeScreen.id);
          } else {
            await API.createUser().then((value) {
              Navigator.pushReplacementNamed(context, HomeScreen.id);
            });
          }
        }
      });
    } catch (e) {
      print(e.toString()); //print error message in console
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      SnackbarWidget.showSnackBar(context, "Check your internet connection!");
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    //initialize media query variable of constants.dart to get the size of the screen and make it available to all the widgets
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Welcome to Flash Chat!!"),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            top: mq.height * .15,
            right: is_animate ? mq.width * .25 : -mq.width * 1.5,
            width: mq.width * .5,
            child: Image.asset("images/logo.png"),
          ),
          Positioned(
            bottom: mq.height * .15,
            left: mq.width * .25,
            width: mq.width * .5,
            child: Column(
              children: [
                GoogleSignInButton(
                  buttonText: "Sign in",
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  icon: Icons.alternate_email,
                ),
                SizedBox(
                  height: 20,
                ),
                GoogleSignInButton(
                  onPressed: () {
                    _handleGooglebtnclick();
                  },
                  buttonText: "Sign in",
                  icon: Icons.g_mobiledata,
                ),
                SizedBox(
                  height: 20,
                ),
                GoogleSignInButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  buttonText: "Register",
                  icon: Icons.account_box_rounded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

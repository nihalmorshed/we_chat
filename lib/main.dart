import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/auth/login_screen.dart';
import 'package:we_chat/screens/chat_screen.dart';
import 'package:we_chat/screens/profile.dart';
import 'package:we_chat/screens/splash_screen.dart';
import 'package:we_chat/screens/welcome_secondary.dart';
import 'package:we_chat/auth/reg_screen.dart';
import 'package:we_chat/screens/home_screen.dart';
import 'package:we_chat/screens/welcome_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.orangeAccent,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      // home: LoginScreen(),
      initialRoute: SplashScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        WelcomeSecondary.id: (context) => WelcomeSecondary(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        // ChatScreen.id: (context) => ChatScreen(),
        // ProfileScreen.id: (context) => ProfileScreen(User: null,),
      },
    );
  }
}

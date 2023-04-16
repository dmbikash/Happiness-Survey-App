import 'package:flutter/material.dart';
import 'package:happiness_survey_android/screen/test.dart';
import 'package:happiness_survey_android/screen/welcome_screen.dart';
import 'package:happiness_survey_android/screen/test3.dart';
import 'package:happiness_survey_android/screen/thankyou.dart';
import 'screen/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      //home: Home(),
      initialRoute: "WelcomeScreen",
      //initialRoute: "Test2",
      routes: {

        "WelcomeScreen": (context)=> const WelcomeScreen(),
        "Home": (context)=> Home(),
        "Test3": (context)=> Test3(),
        "ThankYou": (context)=> ThankYou(),
      },
    );
  }
}


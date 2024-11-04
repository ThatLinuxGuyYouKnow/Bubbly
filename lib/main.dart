import 'package:bubbly/auth/signin.dart';
import 'package:bubbly/auth/signup.dart';
import 'package:bubbly/chat_main.dart';
import 'package:bubbly/welcomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          // '/': (context) => const FirstScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/signup': (context) => SignUp(),
          '/signin': (context) => SignIn(),
          '/mainchat': (context) => ChatMain()
        },
        home: WelcomeScreen());
  }
}

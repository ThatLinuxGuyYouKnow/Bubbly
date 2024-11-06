import 'package:bubbly/auth/signin.dart';
import 'package:bubbly/auth/signup.dart';
import 'package:bubbly/chats/chat_main.dart';
import 'package:bubbly/chats/chat_new.dart';
import 'package:bubbly/welcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  String supabaseUrl = dotenv.env['SUPABASE_URL']!;
  String supabaseKey = dotenv.env['SUPABASE_ANON_KEY']!;
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final session = supabase.auth.currentUser;
    session != null ? print('user is authed') : print('who dis?');
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        title: 'Bubbly',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/signup': (context) => SignUp(),
          '/signin': (context) => SignIn(),
          '/mainchat': (context) => ChatMain(),
          '/newchat': (context) => ChatNew()
        },
        home: session != null ? ChatMain() : WelcomeScreen());
  }
}

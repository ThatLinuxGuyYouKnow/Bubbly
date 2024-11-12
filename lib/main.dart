import 'package:bubbly/auth/set_username.dart';
import 'package:bubbly/auth/signin.dart';
import 'package:bubbly/auth/signup.dart';
import 'package:bubbly/chats/chat_main.dart';
import 'package:bubbly/chats/chat_new.dart';
import 'package:bubbly/splash.dart';
import 'package:bubbly/stacked_screens/homeScreen.dart';
import 'package:bubbly/welcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  String supabaseUrl = dotenv.env['SUPABASE_URL']!;
  String supabaseKey = dotenv.env['SUPABASE_ANON_KEY']!;
  await GetStorage.init('user-data');
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
          '/signup': (context) => const SignUp(),
          '/signin': (context) => const SignIn(),
          '/mainchat': (context) => const ChatMain(),
          '/newchat': (context) => const ChatNew(),
          '/homepage': (context) => const HomeScreen(),
          '/welcomeScreen': (context) => const WelcomeScreen()
        },
        home: SplashScreen());
  }
}

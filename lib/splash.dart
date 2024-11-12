import 'dart:async';
import 'package:bubbly/auth/auth.dart';
import 'package:bubbly/data/localHandling/localData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Ensures the timer only starts after the widgets are fully mounted.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 3), () {
        _routeToScreen();
      });
    });
  }

  void _routeToScreen() {
    final supabase = Supabase.instance.client;
    final session = supabase.auth.currentSession;

    // Navigate to the appropriate screen based on user session status
    final localData = LocalData();
    final String username = localData.getUsername();
    final auth = Auth();

    if (session != null && username == '') {
      auth.signOut(); //even if the user is authed, as long as username is empty, post them to get authed
      Navigator.pushReplacementNamed(context, '/welcomeScreen');
    } else if (session != null && username != '') {
      Navigator.pushReplacementNamed(context, '/mainchat');
    } else if (session == null) {
      Navigator.pushReplacementNamed(context, '/welcomeScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.purple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.bubble_chart_rounded,
            size: 100,
            color: Colors.white,
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bubbly',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

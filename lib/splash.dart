import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  void routeToScreen({final context}) {
    final supabase = Supabase.instance.client;
    final session = supabase.auth.currentSession;
    session != null
        ? Navigator.pushNamed(context, '/homepage')
        : Navigator.pushNamed(context, '/welcomeScreen');
  }

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    Timer(const Duration(seconds: 3), () => routeToScreen(context: context));

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
              )
            ],
          )
        ],
      ),
    );
  }
}

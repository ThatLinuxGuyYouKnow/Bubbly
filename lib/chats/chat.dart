import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  String recipientUsername;
  Chat({super.key, required this.recipientUsername});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          recipientUsername,
          style: GoogleFonts.plusJakartaSans(),
        ),
      ),
    );
  }
}

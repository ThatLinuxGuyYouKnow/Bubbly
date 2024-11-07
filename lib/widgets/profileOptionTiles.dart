import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileOptionsTile extends StatelessWidget {
  ProfileOptionsTile(
      {super.key,
      required this.trailingIcon,
      required this.title,
      required this.onTap});
  final Icon trailingIcon;
  final String title;
  final VoidCallback onTap;
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: screenHeight * 0.03,
        width: screenHeight * 0.8,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(.3))]),
        child: ListTile(
          trailing: CircleAvatar(
            backgroundColor: Colors.purpleAccent.withOpacity(.3),
            child: trailingIcon,
          ),
          title: Text(title, style: GoogleFonts.plusJakartaSans(fontSize: 17)),
        ),
      ),
    );
  }
}

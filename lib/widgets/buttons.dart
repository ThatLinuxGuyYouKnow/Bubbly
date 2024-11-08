import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StandardButton extends StatelessWidget {
  final VoidCallback onButtonTap;
  final String buttonTitle;
  StandardButton(
      {super.key, required this.onButtonTap, required this.buttonTitle});
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        onButtonTap();
      },
      child: Container(
        height: screenHeight * 0.08,
        width: screenWidth * 0.8,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.purple,
            ),
          ],
          color: Colors.purple,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Center(
          child: Text(
            buttonTitle,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

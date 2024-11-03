import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StandardText extends StatelessWidget {
  final String textContent;
  final double? textFontSize;
  final FontWeight? textWeight;
  StandardText(
      {super.key,
      required this.textContent,
      this.textFontSize,
      this.textWeight});
  Widget build(BuildContext context) {
    return Text(
      textContent,
      style: GoogleFonts.plusJakartaSans(
          fontSize: textFontSize ?? 16, fontWeight: textWeight),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileOptionsTile extends StatelessWidget {
  ProfileOptionsTile({
    super.key,
    required this.trailingIcon,
    required this.title,
    required this.onTap,
    this.borderColor,
  });

  final Icon trailingIcon;
  final String title;
  final VoidCallback onTap;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        height: screenHeight * 0.09,
        width: screenWidth * 0.9,
        decoration: BoxDecoration(
          border:
              Border.all(width: 1, color: borderColor ?? Colors.transparent),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.purpleAccent.withOpacity(.2),
              child: trailingIcon,
            ),
          ],
        ),
      ),
    );
  }
}

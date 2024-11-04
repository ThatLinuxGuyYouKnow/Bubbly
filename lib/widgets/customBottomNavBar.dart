import 'package:flutter/material.dart';

class CustomButtomNavBar extends StatelessWidget {
  CustomButtomNavBar({super.key});

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Container(width: screenWidth, height: screenHeight),
    );
  }
}

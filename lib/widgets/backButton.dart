import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key}); // Use 'const' for stateless widgets

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 20,
        backgroundColor:
            Colors.purple.withOpacity(0.1), // Semi-transparent purple
        child: BackButton(color: Colors.purple));
  }
}

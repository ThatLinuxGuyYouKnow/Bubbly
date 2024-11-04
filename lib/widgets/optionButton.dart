import 'package:bubbly/widgets/OndulatingButton.dart';
import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final VoidCallback onButtonPressed;
  OptionButton({super.key, required this.onButtonPressed});

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onButtonPressed();
      },
      child: CircleAvatar(
        backgroundColor: Colors.purple.withOpacity(.1),
        child: Icon(
          Icons.more_horiz,
          color: Colors.purple,
        ),
      ),
    );
  }
}

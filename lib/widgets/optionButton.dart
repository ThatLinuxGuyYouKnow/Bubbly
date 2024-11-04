import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final VoidCallbackAction onButtonPressed;
  OptionButton({super.key, required this.onButtonPressed});

  Widget build(BuildContext context) {
    return IconButton.filled(
        color: Colors.purple.withOpacity(.1),
        onPressed: () {
          onButtonPressed;
        },
        icon: Icon(
          Icons.more_horiz,
          color: Colors.purple,
        ));
  }
}

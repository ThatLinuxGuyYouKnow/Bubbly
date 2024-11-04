import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  OptionButton({super.key});

  Widget build(BuildContext context) {
    return IconButton.filled(onPressed: () {}, icon: Icon(Icons.more_horiz));
  }
}

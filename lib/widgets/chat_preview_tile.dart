import 'package:flutter/material.dart';

class ChatPreviewTile extends StatelessWidget {
  ChatPreviewTile({super.key, required this.BuildContent});
  final List<String> BuildContent;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(BuildContent[0]),
      subtitle: Text(BuildContent[1]),
    );
  }
}

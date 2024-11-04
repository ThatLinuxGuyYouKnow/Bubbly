import 'package:flutter/material.dart';

class ChatPreviewTile extends StatelessWidget {
  ChatPreviewTile({super.key, this.BuildContent});
  final List<String>? BuildContent;
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.purple,
      ),
      title: Text(''),
      subtitle: Text(''),
    );
  }
}

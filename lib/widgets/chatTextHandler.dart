import 'package:flutter/material.dart';

class ChatTextEditingField extends StatelessWidget {
  ChatTextEditingField({super.key, required this.chatController});
  final TextEditingController chatController;
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.05,
      width: screenWidth * 0.7,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: TextField(
        decoration: InputDecoration(hintText: 'chat here'),
        controller: chatController,
      ),
    );
  }
}

class ChatHandler extends StatelessWidget {
  ChatHandler(
      {super.key, required this.chatController, required this.onButtonPressed});
  final TextEditingController chatController;
  final VoidCallback onButtonPressed;
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Row(
        children: [
          ChatTextEditingField(chatController: chatController),
          IconButton(
              onPressed: () {
                onButtonPressed();
              },
              icon: Icon(Icons.send))
        ],
      ),
    );
  }
}

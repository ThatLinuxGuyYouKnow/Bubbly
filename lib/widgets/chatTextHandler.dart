import 'package:flutter/material.dart';

class ChatTextEditingField extends StatelessWidget {
  const ChatTextEditingField({
    super.key,
    required this.chatController,
    required this.onSubmitted,
  });

  final TextEditingController chatController;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 100),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          controller: chatController,
          maxLines: null,
          textInputAction: TextInputAction.send,
          onSubmitted: (_) => onSubmitted(),
          decoration: InputDecoration(
            hintText: 'Type a message...',
            hintStyle: TextStyle(color: Colors.grey[500]),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }
}

class ChatHandler extends StatelessWidget {
  const ChatHandler({
    super.key,
    required this.chatController,
    required this.onButtonPressed,
  });

  final TextEditingController chatController;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          )
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            ChatTextEditingField(
              chatController: chatController,
              onSubmitted: onButtonPressed,
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onButtonPressed,
                  customBorder: const CircleBorder(),
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bubbly/data/localHandling/localData.dart';
import 'package:bubbly/data/localHandling/supabaseData.dart';
import 'package:bubbly/widgets/backButton.dart';
import 'package:bubbly/widgets/chatTextHandler.dart';
import 'package:bubbly/widgets/messageBubble.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  // Changed to StatefulWidget
  final String recipientUsername; // Made final

  const Chat({
    super.key,
    required this.recipientUsername,
  });

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _chat = TextEditingController();
  final SupabaseData _supabaseData = SupabaseData();
  final LocalData _localData = LocalData();
  late final String _senderEmail;
  late final String _senderUsername;

  @override
  void initState() {
    super.initState();
    _senderEmail = _localData.getUserEmail();
    _senderUsername = _localData.getUsername();
  }

  @override
  void dispose() {
    _chat.dispose(); // Clean up the controller
    super.dispose();
  }

  void _handleSendMessage() async {
    if (_chat.text.trim().isEmpty) return; // Don't send empty messages

    try {
      await _supabaseData.addChat(
        messageContent: _chat.text,
        senderUsername: _senderUsername,
        senderEmail: _senderEmail,
        receiverUsername: widget.recipientUsername,
      );
      _chat.clear(); // Clear the input field after sending
    } catch (e) {
      if (mounted) {
        // Check if widget is still mounted
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send message: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ChatHandler(
        chatController: _chat,
        onButtonPressed: _handleSendMessage,
      ),
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(
          '@${widget.recipientUsername}',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _supabaseData.messageStream(
          currentUsername: _senderUsername,
          recipientUsername: widget.recipientUsername,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading messages: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No messages yet',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            );
          }

          final messages = snapshot.data!;
          return ListView.builder(
            reverse: true, // Show latest messages at the bottom
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final isMe = message['sender_username'] == _senderUsername;

              return MessageBubble(
                message: message['message_content'],
                isMe: isMe,
                timestamp: DateTime.parse(message['created_at']),
              );
            },
          );
        },
      ),
    );
  }
}

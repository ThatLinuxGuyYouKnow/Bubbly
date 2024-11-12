import 'package:bubbly/chats/chat.dart';
import 'package:bubbly/data/localHandling/localData.dart';
import 'package:bubbly/data/localHandling/supabaseData.dart';
import 'package:bubbly/widgets/chat_preview_tile.dart';
import 'package:bubbly/widgets/customBottomNavBar.dart';
import 'package:bubbly/widgets/optionButton.dart';
import 'package:bubbly/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMain extends StatefulWidget {
  const ChatMain({super.key});
  @override
  State createState() => _ChatMainState();
}

class _ChatMainState extends State<ChatMain> {
  final ScrollController _scrollController = ScrollController();
  final SupabaseData _supabaseData = SupabaseData();
  late Future<List<Map<String, dynamic>>> _conversationsFuture;

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  void _loadConversations() {
    // Replace with actual username and email from your auth state
    final localData = LocalData();
    final String username = localData.getUsername()!;
    _conversationsFuture = _supabaseData.getConversations(
      currentUsername: username, // Replace with actual username
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String _getOtherParticipant(
      Map<String, dynamic> conversation, String currentUsername) {
    return conversation['sender_username'] == currentUsername
        ? conversation['receiver_username']
        : conversation['sender_username'];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: screenHeight * 0.2,
            pinned: true,
            backgroundColor: Colors.purpleAccent.withOpacity(.04),
            elevation: 0,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.05),
                child: OptionButton(onButtonPressed: () {}),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1.0,
              titlePadding: EdgeInsets.only(
                left: screenWidth * 0.05,
                bottom: screenHeight * 0.02,
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.bubble_chart,
                        color: Colors.purpleAccent,
                        size: 36,
                      ),
                      SizedBox(width: 8),
                      StandardText(
                        textContent: 'Chats',
                        textFontSize: 25,
                        textWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    'Welcome back to the hive!',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.purple,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.06,
                  right: screenWidth * 0.06,
                  top: screenHeight * 0.02),
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _conversationsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error loading conversations: ${snapshot.error}',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'No conversations yet',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }

                  final localData = LocalData();
                  final String currentUsername = localData.getUsername()!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data!.map((conversation) {
                      final otherParticipant =
                          _getOtherParticipant(conversation, currentUsername);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Chat(
                                      recipientUsername: otherParticipant)));
                        },
                        child: ChatPreviewTile(
                          BuildContent: [
                            otherParticipant,
                            conversation['message_content'] ?? 'No message',
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

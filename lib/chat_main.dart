import 'package:bubbly/auth/auth.dart';
import 'package:bubbly/widgets/chat_preview_tile.dart';
import 'package:bubbly/widgets/optionButton.dart';
import 'package:flutter/material.dart';
import 'package:bubbly/widgets/StandardTextField.dart';
import 'package:bubbly/widgets/backButton.dart';
import 'package:bubbly/widgets/buttons.dart';
import 'package:bubbly/widgets/texts.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMain extends StatefulWidget {
  const ChatMain({super.key});

  @override
  State<ChatMain> createState() => _ChatMainState();
}

class _ChatMainState extends State<ChatMain> {
  final List<Map<String, String>> _sampleChatPreviews = [
    {
      'title': 'John Doe',
      'subtitle': 'Hey, how are you?',
    },
    {
      'title': 'Jane Smith',
      'subtitle': 'Did you see the latest update?',
    },
    {
      'title': 'Michael Johnson',
      'subtitle': 'Lets catch up later today.',
    },
    {
      'title': 'Sarah Williams',
      'subtitle': 'Im running late, sorry!',
    },
  ];
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
            expandedHeight: screenHeight * 0.2,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leadingWidth: screenWidth * 0.23,
            leading: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [OptionButton(onButtonPressed: () {})],
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1.0,
              titlePadding: EdgeInsets.only(
                left: screenWidth * 0.05,
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StandardText(
                    textContent: 'Chats',
                    textFontSize: 35,
                    textWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    'Welcome back to the hive !',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _sampleChatPreviews.map((preview) {
                  return ChatPreviewTile(
                    BuildContent: [preview['title']!, preview['subtitle']!],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

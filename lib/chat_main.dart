import 'package:bubbly/widgets/chat_preview_tile.dart';
import 'package:bubbly/widgets/customBottomNavBar.dart';
import 'package:bubbly/widgets/optionButton.dart';
import 'package:bubbly/widgets/texts.dart';
import 'package:flutter/material.dart';

class ChatMain extends StatefulWidget {
  const ChatMain({super.key});

  @override
  State createState() => _ChatMainState();
}

class _ChatMainState extends State {
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
      'subtitle': 'Let’s catch up later today.',
    },
    {
      'title': 'Sarah Williams',
      'subtitle': 'I’m running late, sorry!',
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
      bottomNavigationBar: CustomBottomNavBar(),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: screenHeight * 0.2,
            pinned: true,
            backgroundColor: Colors.white,
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
                      StandardText(
                        textContent: 'Chats',
                        textFontSize: 35,
                        textWeight: FontWeight.bold,
                      ),
                      SizedBox(width: 8), // Adjust spacing as needed
                      Icon(Icons.bubble_chart, color: Colors.purple),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    'Welcome back to the hive!',
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
              padding: EdgeInsets.only(
                  left: screenWidth * 0.06,
                  right: screenWidth * 0.06,
                  top: screenHeight * 0.02),
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

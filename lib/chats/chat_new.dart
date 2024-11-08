import 'package:bubbly/widgets/StandardTextField.dart';
import 'package:bubbly/widgets/backButton.dart';
import 'package:bubbly/widgets/buttons.dart';
import 'package:bubbly/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatNew extends StatefulWidget {
  const ChatNew({super.key});

  @override
  State createState() => _ChatNewState();
}

class _ChatNewState extends State {
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
            automaticallyImplyLeading: false,
            expandedHeight: screenHeight * 0.2,
            pinned: true,
            backgroundColor: Colors.purpleAccent.withOpacity(.02),
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.02),
              child: const CustomBackButton(),
            ),
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
                        textContent: 'New Chat',
                        textFontSize: 35,
                        textWeight: FontWeight.bold,
                      ),
                      SizedBox(width: 8), // Adjust spacing as needed
                      Icon(Icons.bubble_chart, color: Colors.purple),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    'Reach out to someone new!',
                    style: GoogleFonts.plusJakartaSans(
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
                  children: [
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    StandardText(
                      textContent: 'Enter frens username',
                      textFontSize: 22,
                      textWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    StandardTextEditingField(
                        valueValidator: (value) {}, hintText: '@admin'),
                    SizedBox(height: screenHeight * 0.2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StandardButton(
                          onButtonTap: () {},
                          buttonTitle: 'Start A Converation',
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

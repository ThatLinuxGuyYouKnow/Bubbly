import 'package:bubbly/data/localHandling/supabaseData.dart';
import 'package:bubbly/widgets/StandardTextField.dart';
import 'package:bubbly/widgets/backButton.dart';
import 'package:bubbly/widgets/buttons.dart';
import 'package:bubbly/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SetUsername extends StatefulWidget {
  String email;
  SetUsername({super.key, required this.email});

  @override
  State<SetUsername> createState() => _SetUsernameState();
}

class _SetUsernameState extends State<SetUsername> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController usernameController = TextEditingController();

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final supabasedata = SupabaseData();

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: screenHeight * 0.22,
            pinned: true,
            backgroundColor: Colors.purpleAccent.withOpacity(.04),
            elevation: 0,
            leadingWidth: screenWidth * 0.23,
            leading: SizedBox.shrink(),
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
                    textContent: 'Set up your username',
                    textFontSize: 22,
                    textWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    'Make it nice, make it you !',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.purple,
                      fontSize: 15,
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
                  children: [
                    SizedBox(height: screenHeight * 0.05),
                    StandardText(
                      textContent: 'Your Username',
                      textFontSize: 15,
                      textWeight: FontWeight.bold,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    StandardTextEditingField(
                        controller: usernameController,
                        valueValidator: (value) {},
                        hintText: '@funkylolipop'),
                    SizedBox(height: screenHeight * .3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StandardButton(
                            onButtonTap: () {
                              print(usernameController.text +
                                  'this should *NOT* be null');
                              supabasedata.registerNewUsername(
                                  username: usernameController.text,
                                  email: widget.email);
                            },
                            buttonTitle: 'Register'),
                      ],
                    )
                  ] ///////////////
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

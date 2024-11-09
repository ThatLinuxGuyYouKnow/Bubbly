import 'package:bubbly/auth/auth.dart';
import 'package:bubbly/data/localHandling/localData.dart';
import 'package:bubbly/widgets/StandardTextField.dart';
import 'package:bubbly/widgets/profileOptionTiles.dart';
import 'package:bubbly/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserScreen extends StatelessWidget {
  UserScreen({super.key});
  final ScrollController _scrollController = ScrollController();

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final localdata = LocalData();
    String username = localdata.getUsername();
    String email = localdata.getUserEmail();
    final auth = Auth();
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: screenHeight * 0.2,
            pinned: true,
            backgroundColor: Colors.purpleAccent.withOpacity(.04),
            elevation: 0,
            leadingWidth: screenWidth * 0.23,
            leading: const SizedBox.shrink(),
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
                    textContent: 'Profile',
                    textFontSize: 25,
                    textWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
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
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      username,
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.purple,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    ProfileOptionsTile(
                      title: 'Log out',
                      onTap: () {
                        auth.signOut();
                      },
                      trailingIcon: Icon(Icons.logout),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    ProfileOptionsTile(
                      title: 'Invite Friends',
                      onTap: () {},
                      trailingIcon: Icon(Icons.account_box),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    ProfileOptionsTile(
                      title: 'Request your account data',
                      onTap: () {},
                      trailingIcon: Icon(Icons.download),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    ProfileOptionsTile(
                      borderColor: Colors.red,
                      title: 'Delete Account',
                      onTap: () {},
                      trailingIcon: Icon(Icons.cancel),
                    ),
                  ] ///////////////
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

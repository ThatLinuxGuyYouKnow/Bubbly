import 'package:flutter/material.dart';
import 'package:bubbly/widgets/StandardTextField.dart';
import 'package:bubbly/widgets/backButton.dart';
import 'package:bubbly/widgets/buttons.dart';
import 'package:bubbly/widgets/texts.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool passwordMadeVisible = false;
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
              child: const CustomBackButton(),
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
                    textContent: 'Sign Up',
                    textFontSize: 35,
                    textWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    'Join the buzz, share your story !',
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
                children: [
                  SizedBox(height: screenHeight * 0.06),
                  StandardText(
                    textContent: 'Username',
                    textFontSize: 22,
                    textWeight: FontWeight.bold,
                  ),
                  SizedBox(height: screenHeight * .02),
                  StandardTextEditingField(
                    valueValidator: (value) {},
                    hintText: 'Email',
                  ),
                  SizedBox(height: screenHeight * .05),
                  StandardText(
                    textContent: 'Password',
                    textFontSize: 22,
                    textWeight: FontWeight.bold,
                  ),
                  SizedBox(height: screenHeight * .02),
                  StandardTextEditingField(
                    trailingWidget: GestureDetector(
                      onTap: () => setState(() {
                        passwordMadeVisible = !passwordMadeVisible;
                      }),
                      child: Icon(
                        passwordMadeVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.blue,
                      ),
                    ),
                    valueValidator: (value) {},
                    hintText: 'Password',
                    obscureText: !passwordMadeVisible,
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StandardButton(
                        onButtonTap: () {},
                        buttonTitle: 'Get Started',
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/signin'),
                        child: Row(
                          children: [
                            Text(
                              'Already have an account?',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.02,
                            ),
                            Text('Dive Back in! ',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline))
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

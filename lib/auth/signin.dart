import 'package:flutter/material.dart';
import 'package:bubbly/widgets/StandardTextField.dart';
import 'package:bubbly/widgets/backButton.dart';
import 'package:bubbly/widgets/buttons.dart';
import 'package:bubbly/widgets/texts.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
            expandedHeight: screenHeight * 0.15,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leadingWidth: screenWidth * 0.23,
            leading: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.01),
              child: const CustomBackButton(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1.0,
              titlePadding: EdgeInsets.only(
                left: screenWidth * 0.05,
                bottom: 16,
              ),
              title: StandardText(
                textContent: 'Sign In',
                textFontSize: 35,
                textWeight: FontWeight.bold,
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
                    textFontSize: 25,
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
                    textFontSize: 25,
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
                        color: Colors.grey,
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
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account ?'),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Text(
                          'Get Back In',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

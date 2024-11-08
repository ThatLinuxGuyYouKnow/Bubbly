import 'package:bubbly/auth/auth.dart';
import 'package:bubbly/auth/set_username.dart';
import 'package:flutter/material.dart';
import 'package:bubbly/widgets/StandardTextField.dart';
import 'package:bubbly/widgets/backButton.dart';
import 'package:bubbly/widgets/buttons.dart';
import 'package:bubbly/widgets/texts.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool passwordMadeVisible = false;
  final ScrollController _scrollController = ScrollController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final auth = Auth();
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
                    textFontSize: 25,
                    textWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    'Join the buzz, share your story !',
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
                  SizedBox(height: screenHeight * 0.06),
                  StandardText(
                    textContent: 'Email',
                    textFontSize: 18,
                    textWeight: FontWeight.bold,
                  ),
                  SizedBox(height: screenHeight * .02),
                  StandardTextEditingField(
                    controller: _usernameController,
                    valueValidator: (value) {},
                    hintText: 'Email',
                  ),
                  SizedBox(height: screenHeight * .05),
                  StandardText(
                    textContent: 'Password',
                    textFontSize: 18,
                    textWeight: FontWeight.bold,
                  ),
                  SizedBox(height: screenHeight * .02),
                  StandardTextEditingField(
                    controller: _passwordController,
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
                        onButtonTap: () {
                          print("controller" + _usernameController.text);
                          auth.signUp(
                            email: _usernameController.text,
                            password: _passwordController.text.trim(),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => SetUsername(
                                email: _usernameController.text,
                              ),
                            ),
                          );
                        },
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
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.02,
                            ),
                            Text('Dive Back in! ',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
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

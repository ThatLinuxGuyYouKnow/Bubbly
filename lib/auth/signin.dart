import 'package:bubbly/auth/auth.dart';
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
  final auth = Auth();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

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
                    textContent: 'Sign In',
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
                children: [
                  SizedBox(height: screenHeight * 0.06),
                  StandardText(
                    textContent: 'Email',
                    textFontSize: 22,
                    textWeight: FontWeight.bold,
                  ),
                  SizedBox(height: screenHeight * .02),
                  StandardTextEditingField(
                    controller: _emailController,
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
                    controller: passwordController,
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
                        onButtonTap: () {
                          print('email controller' + _emailController.text);
                          auth.signIn(
                              onSuccessfulAuth: () =>
                                  Navigator.pushNamed(context, '/homepage'),
                              email: _emailController.text.trim(),
                              password: passwordController.text.trim());
                        },
                        buttonTitle: 'Get Back In',
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/signup'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont have an account?',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Text('Join Us! ',
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.purple))
                      ],
                    ),
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

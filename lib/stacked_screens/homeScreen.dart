import 'package:flutter/material.dart';
import 'package:bubbly/widgets/customBottomNavBar.dart';
import 'package:bubbly/chats/chat_main.dart';
import 'package:bubbly/stacked_screens/userProfile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  bool _edgeOptionPicked =
      true; // Initialize the state based on the default value

  final List<Widget> _screens = [
    UserScreen(),
    const ChatMain(),
    UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onOption1Selected: () {
          setState(() {
            _currentIndex = 0;
          });
        },
        onOtption2Selected: () {
          setState(() {
            _currentIndex == 1
                ? Navigator.pushNamed(context, '/newchat')
                : _currentIndex = 1;
          });
        },
        onOption3Selected: () => setState(() {
          _currentIndex = 2;
        }),
      ),
    );
  }
}

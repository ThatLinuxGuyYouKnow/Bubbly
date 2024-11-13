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

  void _onNavItemTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 1 && _edgeOptionPicked) {
      Navigator.pushNamed(context, '/newchat');
    } else if (index == 0) {
      Navigator.pushNamed(context, '/homepage');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/you');
    }
  }

  void _onEdgeOptionPickedChanged(bool value) {
    setState(() {
      _edgeOptionPicked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onOption1Selected: () => _currentIndex = 1,
        onOtption2Selected: () => _currentIndex == 2
            ? Navigator.pushNamed(context, '/newchat')
            : _currentIndex = 2,
        onOption3Selected: () => _currentIndex = 3,
      ),
    );
  }
}

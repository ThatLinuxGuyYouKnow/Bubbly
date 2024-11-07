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
  int _currentIndex = 1; //so it always lands on the main chat widget by default

  final List<Widget> _screens = [
    UserScreen(),
    const ChatMain(),
    UserScreen(),
  ];

  void _onNavItemTap(int index) {
    setState(() {
      _currentIndex = index;
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
        onTap: _onNavItemTap,
      ),
    );
  }
}

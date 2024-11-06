import 'package:flutter/material.dart';
import 'package:bubbly/widgets/customBottomNavBar.dart';
import 'package:bubbly/chats/chat_main.dart';
// Import other screens as needed

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // List of screens for each tab
  final List<Widget> _screens = [
    ChatMain(), // Replace with actual screens
    ChatMain(), // Placeholder for "Near You" screen
    ChatMain(), // Placeholder for "Profile" screen
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

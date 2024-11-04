import 'package:flutter/material.dart';

class CustomButtomNavBar extends StatelessWidget {
  CustomButtomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white, // Background color of nav bar
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
      width: screenWidth,
      height: screenHeight * 0.08, // Increase height for visibility
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              // Define onTap action for Search
              print('Search tapped');
            },
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.purple),
                SizedBox(width: 5), // Small spacing
                Text('Search', style: TextStyle(color: Colors.purple)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Define onTap action for Home
              print('Home tapped');
            },
            child: Icon(Icons.home, color: Colors.purple),
          ),
          GestureDetector(
            onTap: () {
              // Define onTap action for Profile
              print('Profile tapped');
            },
            child: Icon(Icons.person, color: Colors.purple),
          ),
        ],
      ),
    );
  }
}

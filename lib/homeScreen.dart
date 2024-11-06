import 'package:flutter/material.dart';
import 'package:bubbly/widgets/customBottomNavBar.dart';
import 'package:bubbly/chats/chat_main.dart';
import 'package:google_fonts/google_fonts.dart';
// Import other screens as needed

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    required this.currentIndex,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 10,
          top: 8,
          left: screenWidth * 0.075,
          right: screenWidth * 0.075,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                blurRadius: 30,
              ),
            ],
          ),
          height: screenHeight * 0.09,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                label: 'Near You',
                icon: Icons.online_prediction,
                isSelected: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              _buildNavItem(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                icon: Icons.add,
                label: 'New Chat',
                isSelected: currentIndex == 1,
                onTap: () => onTap(1),
              ),
              _buildNavItem(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                icon: Icons.person,
                label: 'You',
                isSelected: currentIndex == 2,
                onTap: () => onTap(2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    String? label,
    required bool isSelected,
    required VoidCallback onTap,
    required double screenHeight,
    required double screenWidth,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: screenHeight * 0.06,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 50.0 : 12.0,
          vertical: 3.0,
        ),
        decoration: ShapeDecoration(
          color: isSelected ? Colors.purpleAccent : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.purple,
            ),
            if (label != null && isSelected) ...[
              SizedBox(width: 5),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

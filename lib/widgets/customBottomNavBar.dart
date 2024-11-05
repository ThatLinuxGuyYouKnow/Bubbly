import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  bool navbarItemSearchSelected = false;
  bool navbarItemHomeSelected = true;
  bool navbarItemUserSelected = false;

  void _selectNavItem(String item) {
    setState(() {
      navbarItemSearchSelected = item == 'search';
      navbarItemHomeSelected = item == 'home';
      navbarItemUserSelected = item == 'user';
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Wrap with SafeArea to respect system UI elements
    return SafeArea(
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 40,
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
                label: 'Search',
                icon: Icons.search_rounded,
                isSelected: navbarItemSearchSelected,
                onTap: () => _selectNavItem('search'),
              ),
              _buildNavItem(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                icon: Icons.add,
                label: 'New Chat',
                isSelected: navbarItemHomeSelected,
                onTap: () => _selectNavItem('home'),
              ),
              _buildNavItem(
                label: 'You',
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                icon: Icons.person,
                isSelected: navbarItemUserSelected,
                onTap: () => _selectNavItem('user'),
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
          color: isSelected ? Colors.purple : Colors.transparent,
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

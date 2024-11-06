import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Material(
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom +
              35, // Increased bottom padding
          top: 8,
          left: screenWidth * 0.075,
          right: screenWidth * 0.075,
        ),
        margin: const EdgeInsets.only(bottom: 16), // Added bottom margin
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                blurRadius: 30,
                offset: const Offset(0, 5), // Added shadow offset
              ),
            ],
          ),
          height: screenHeight * 0.08, // Slightly reduced height
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                label: 'Near You',
                icon: Icons.online_prediction,
                isSelected: widget.currentIndex == 0,
                onTap: () => widget.onTap(0),
              ),
              _buildNavItem(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                icon: Icons.add,
                label: 'New Chat',
                isSelected: widget.currentIndex == 1,
                onTap: () => widget.onTap(1),
              ),
              _buildNavItem(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                icon: Icons.person,
                label: 'You',
                isSelected: widget.currentIndex == 2,
                onTap: () => widget.onTap(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildNavItem({
  required IconData icon,
  String? label,
  required bool isSelected,
  required VoidCallback onTap,
  required double screenHeight,
  required double screenWidth,
}) {
  return SafeArea(
    child: Material(
      // Added Material widget wrapper
      color: Colors.transparent,
      child: InkWell(
        // Replaced GestureDetector with InkWell
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: screenHeight * 0.06,
          padding: EdgeInsets.symmetric(
            horizontal: isSelected ? 20.0 : 12.0,
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
                const SizedBox(width: 5),
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
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final VoidCallback onOption1Selected;
  final VoidCallback onOtption2Selected;
  final VoidCallback onOption3Selected;
  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onOption1Selected,
    required this.onOtption2Selected,
    required this.onOption3Selected,
  }) : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  bool edgeOptionPicked = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Material(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 35,
            top: 5,
            left: screenWidth * 0.075,
            right: screenWidth * 0.075,
          ),
          margin: const EdgeInsets.only(bottom: 16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  blurRadius: 30,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            height: screenHeight * 0.09,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(
                  icon: Icons.online_prediction,
                  label: 'Near You',
                  isSelected: widget.currentIndex == 0,
                  onTap: () {
                    edgeOptionPicked = true;
                    widget.onOption1Selected();
                  },
                ),
                _buildNavItem(
                    icon:
                        edgeOptionPicked ? Icons.chat_bubble_sharp : Icons.add,
                    label: edgeOptionPicked ? 'Chats' : 'New Chat',
                    isSelected: widget.currentIndex == 1,
                    onTap: () => widget.onOtption2Selected()),
                _buildNavItem(
                  icon: Icons.person,
                  label: 'You',
                  isSelected: widget.currentIndex == 2,
                  onTap: () {
                    edgeOptionPicked = true;
                    print('edge option3 selected');
                    widget.onOption3Selected();
                  },
                ),
              ],
            ),
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
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(
            horizontal: isSelected ? 20.0 : 12.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: isSelected ? Colors.purpleAccent : Colors.transparent,
            borderRadius: BorderRadius.circular(50),
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
    );
  }
}

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
  bool edgeOptionPicked = false;

  void _onItemTapped(int index) {
    setState(() {
      if (index == 1) {
        edgeOptionPicked = !edgeOptionPicked;
      } else {
        edgeOptionPicked = true;
      }
      widget.onTap(index);
    });
    if (index == 1 && !edgeOptionPicked) {
      Navigator.pushNamed(context, '/newchat');
    }
  }

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
            top: 8,
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
            height: screenHeight * 0.08,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(
                  icon: Icons.online_prediction,
                  label: 'Near You',
                  isSelected: widget.currentIndex == 0,
                  onTap: () => _onItemTapped(0),
                ),
                _buildNavItem(
                  icon: edgeOptionPicked ? Icons.chat_bubble_sharp : Icons.add,
                  label: edgeOptionPicked ? 'Chats' : 'New Chat',
                  isSelected: widget.currentIndex == 1,
                  onTap: () => _onItemTapped(1),
                ),
                _buildNavItem(
                  icon: Icons.person,
                  label: 'You',
                  isSelected: widget.currentIndex == 2,
                  onTap: () => _onItemTapped(2),
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
            vertical: 3.0,
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

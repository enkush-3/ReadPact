import 'package:flutter/material.dart';
import '../Service/theme_service.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final Color? background;
  final AppColors? colors; // added optional AppColors param

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.background,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // prefer provided AppColors, otherwise use Theme values
    final cardBg = background ?? (colors?.cardBackground ?? theme.cardColor);
    final primary = colors?.primary ?? theme.primaryColor;
    final textColor = colors?.text ?? (theme.textTheme.bodyMedium?.color ?? Colors.black);

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: cardBg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_outlined, 0, primary, textColor),
          _buildNavItem(Icons.apps_outlined, 1, primary, textColor),
          _buildNavItem(Icons.search_outlined, 2, primary, textColor),
          _buildNavItem(Icons.bookmark_border_outlined, 3, primary, textColor),
          _buildNavItem(Icons.person_outline, 4, primary, textColor),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, Color primary, Color textColor) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Icon(
          icon,
          size: 28,
          color: isSelected ? primary : textColor.withOpacity(0.5),
        ),
      ),
    );
  }
}

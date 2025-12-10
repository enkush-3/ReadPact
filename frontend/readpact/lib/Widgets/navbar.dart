import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Service/theme_service.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final Color? background;
  final AppColors? colors;

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
    final cardBg = background ?? (colors?.cardBackground ?? theme.cardColor);
    final primary = colors?.primary ?? theme.primaryColor;
    final iconColor = colors?.text ?? theme.iconTheme.color ?? Colors.grey;

    final iconPaths = [
      'assets/icons/home.svg',
      'assets/icons/apps.svg',
      'assets/icons/search.svg',
      'assets/icons/bookmark.svg',
      'assets/icons/person.svg',
    ];

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: cardBg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(iconPaths.length, (index) {
          final isSelected = currentIndex == index;
          final color = isSelected ? primary : iconColor.withOpacity(0.7);

          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: SvgPicture.asset(
                  iconPaths[index],
                  width: 26,
                  height: 26,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Service/theme_service.dart';

class AppHeader extends StatelessWidget {
  final bool showTitle;

  const AppHeader({super.key, this.showTitle = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        final colors = themeService.colors;
        final isDarkMode = themeService.isDarkMode;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showTitle)
                Row(
                  children: [
                    Text(
                      'Read',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      'Pact',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
                    ),
                  ],
                )
              else
                // Spacer or simple SizedBox if no title, but we want the theme button aligned right.
                // If title is missing, the Row mainAxisAlignment: MainAxisAlignment.spaceBetween
                // will push the single child (Theme Button) to the start or center depending on implementation.
                // Wait, spaceBetween with 1 child places it at start.
                // We likely want the theme button at the END (right).
                // So if !showTitle, insert a Spacer() or just use MainAxisAlignment.end if only 1 item?
                // Easier: Just add a Spacer() if showTitle is false? No, spaceBetween handles 2 items.
                // If 1 item, it goes to start.
                // So we need a dummy widget at start if hidden? Or just use Expanded/Spacer.
                const SizedBox.shrink(),

              IconButton(
                icon: Icon(
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: colors.text,
                ),
                onPressed: themeService.toggleTheme,
              ),
            ],
          ),
        );
      },
    );
  }
}

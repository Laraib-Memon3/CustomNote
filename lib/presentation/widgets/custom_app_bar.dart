import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/themes/app_theme.dart';
import '../providers/theme_provider.dart';

/// Custom app bar widget with theme toggle functionality.
///
/// Provides a consistent app bar across the application with
/// optional search, theme toggle, and custom actions.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Title displayed in the app bar.
  final String title;

  /// Whether to show the search icon.
  final bool showSearch;

  /// Whether to show the theme toggle button.
  final bool showThemeToggle;

  /// Callback when search is tapped.
  final VoidCallback? onSearchTap;

  /// Custom leading widget (overrides default back button).
  final Widget? leading;

  /// Additional action widgets.
  final List<Widget>? actions;

  /// Whether to center the title.
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showSearch = false,
    this.showThemeToggle = true,
    this.onSearchTap,
    this.leading,
    this.actions,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return AppBar(
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).appBarTheme.foregroundColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          centerTitle: centerTitle,
          leading: leading,
          actions: _buildActions(context, themeProvider),
          elevation: 0,
        );
      },
    );
  }

  List<Widget> _buildActions(BuildContext context, ThemeProvider themeProvider) {
    final actionList = <Widget>[];

    // Add search icon if enabled
    if (showSearch) {
      actionList.add(
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: onSearchTap,
          tooltip: 'Search notes',
        ),
      );
    }

    // Add theme toggle button if enabled
    if (showThemeToggle) {
      actionList.add(
        PopupMenuButton<AppThemeMode>(
          icon: Icon(_getThemeIcon(themeProvider.themeMode)),
          tooltip: 'Change theme',
          onSelected: (mode) => themeProvider.setThemeMode(mode),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: AppThemeMode.light,
              child: Row(
                children: [
                  Icon(
                    Icons.light_mode,
                    color: themeProvider.isLightMode
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  const SizedBox(width: AppDimensions.paddingS),
                  Text(
                    AppStrings.lightMode,
                    style: TextStyle(
                      fontWeight: themeProvider.isLightMode
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: AppThemeMode.dark,
              child: Row(
                children: [
                  Icon(
                    Icons.dark_mode,
                    color: themeProvider.isDarkMode
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  const SizedBox(width: AppDimensions.paddingS),
                  Text(
                    AppStrings.darkMode,
                    style: TextStyle(
                      fontWeight: themeProvider.isDarkMode
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: AppThemeMode.pastel,
              child: Row(
                children: [
                  Icon(
                    Icons.palette,
                    color: themeProvider.isPastelMode
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  const SizedBox(width: AppDimensions.paddingS),
                  Text(
                    AppStrings.pastelMode,
                    style: TextStyle(
                      fontWeight: themeProvider.isPastelMode
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Add custom actions if provided
    if (actions != null) {
      actionList.addAll(actions!);
    }

    return actionList;
  }

  IconData _getThemeIcon(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return Icons.light_mode;
      case AppThemeMode.dark:
        return Icons.dark_mode;
      case AppThemeMode.pastel:
        return Icons.palette;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

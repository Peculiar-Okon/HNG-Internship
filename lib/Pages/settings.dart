import '../core.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SwitchListTile(
          title: const Text('Dark Mode'),
          value: themeProvider.isDarkMode,
          onChanged: (_) {
            themeProvider.toggleTheme();
          },
          secondary: Icon(
            themeProvider.isDarkMode
                ? Icons.dark_mode
                : Icons.light_mode,
            color: colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
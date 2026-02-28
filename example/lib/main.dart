import 'package:cloudscape_flutter_uikit/cloudscape_flutter_uikit.dart';
import 'package:flutter/material.dart';

void main() {
  final themeController = CloudscapeThemeController();
  runApp(MyApp(themeController: themeController));
}

class MyApp extends StatelessWidget {
  final CloudscapeThemeController themeController;

  const MyApp({super.key, required this.themeController});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeController,
      builder: (context, _) {
        return MaterialApp(
          title: 'Cloudscape Flutter UI Kit',
          theme: CloudscapeTheme.light(),
          darkTheme: CloudscapeTheme.dark(),
          debugShowCheckedModeBanner: false,
          themeMode: themeController.themeMode,
          home: const UiKitExample(),
          builder: (context, child) {
            return ThemeControllerWrapper(
              themeController: themeController,
              child: child!,
            );
          },
        );
      },
    );
  }
}

class ThemeControllerWrapper extends StatelessWidget {
  final Widget child;
  final CloudscapeThemeController themeController;

  const ThemeControllerWrapper({
    super.key,
    required this.child,
    required this.themeController,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          child,
          Positioned(
            right: CloudscapeSpacing.medium,
            bottom: CloudscapeSpacing.medium,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: isDarkMode
                  ? CloudscapePalette.darkContainer
                  : CloudscapePalette.white,
              elevation: 4,
              shape: const CircleBorder(),
              onPressed: () {
                themeController.toggleTheme();
              },
              child: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: isDarkMode
                    ? CloudscapePalette.white
                    : CloudscapePalette.grey900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UiKitExample extends StatelessWidget {
  const UiKitExample({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = CloudscapeThemeExtension.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloudscape Card Showcase'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(CloudscapeSpacing.large),
        child: Wrap(
          spacing: CloudscapeSpacing.medium,
          runSpacing: CloudscapeSpacing.medium,
          children: [
            // Card that looks like the User's provided image (Alert demo)
            SizedBox(
              width: 400,
              child: CloudscapeCard(
                header: Container(
                  height: 50,
                  color: Colors
                      .transparent, // Let parent handle the background color
                  child: Center(
                    child: Text(
                      'Card header',
                      style: CloudscapeTypography.bodyM.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colors.textHeadingDefault,
                      ),
                    ),
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A brief message that provides information or instructs users to take a specific action.',
                      style: CloudscapeTypography.bodyM.copyWith(
                        color: theme.colors.textBodyDefault,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Simple Card Example
            const SizedBox(
              width: 300,
              child: CloudscapeCard(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Simple Card Content'),
                    SizedBox(height: 8),
                    Text('This is a card without a header section.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

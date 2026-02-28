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
    final spacing = context.cloudscapeSpacing;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          child,
          Positioned(
            right: spacing.scaledM,
            bottom: spacing.scaledM,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: isDarkMode
                  ? context
                        .cloudscapeColors
                        .tokens
                        .colorBackgroundContainerContent
                  : Colors.white,
              elevation: 4,
              shape: const CircleBorder(),
              onPressed: () {
                themeController.toggleTheme();
              },
              child: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: isDarkMode ? Colors.white : Colors.black,
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
    final colors = context.cloudscapeColors;
    final typography = context.cloudscapeTypography;
    final spacing = context.cloudscapeSpacing;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloudscape Card Showcase'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spacing.scaledL),
        child: Wrap(
          spacing: spacing.scaledM,
          runSpacing: spacing.scaledM,
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
                      style: typography.bodyM.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colors.tokens.colorTextHeadingDefault,
                      ),
                    ),
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A brief message that provides information or instructs users to take a specific action.',
                      style: typography.bodyM.copyWith(
                        color: colors.tokens.colorTextBodyDefault,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Simple Card Example
            SizedBox(
              width: 300,
              child: CloudscapeCard(
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Simple Card Content', style: typography.headingS),
                    SizedBox(height: spacing.scaledXs),
                    Text(
                      'This is a card without a header section.',
                      style: typography.bodyM,
                    ),
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

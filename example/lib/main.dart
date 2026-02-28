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
    return Scaffold(
      body: Center(
        child: Text('Hello World', style: CloudscapeTypography.headingXL),
      ),
    );
  }
}

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
    final typography = context.cloudscapeTypography;
    final spacing = context.cloudscapeSpacing;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cloudscape Typography Showcase',
          style: typography.displayNormal,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spacing.scaledL),
        child: Wrap(
          spacing: spacing.scaledM,
          runSpacing: spacing.scaledM,
          children: [
            SizedBox(
              width: 700,
              child: CloudscapeCard(
                header: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: spacing.scaledM),
                  child: Text(
                    'Typography Showcase',
                    style: typography.headingL,
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ShowcaseItem(
                      label: 'displayBold',
                      style: typography.displayBold,
                    ),
                    _ShowcaseItem(
                      label: 'displayNormal',
                      style: typography.displayNormal,
                    ),
                    _ShowcaseItem(
                      label: 'headingXl',
                      style: typography.headingXl,
                    ),
                    _ShowcaseItem(
                      label: 'headingL',
                      style: typography.headingL,
                    ),
                    _ShowcaseItem(
                      label: 'headingM',
                      style: typography.headingM,
                    ),
                    _ShowcaseItem(
                      label: 'headingS',
                      style: typography.headingS,
                    ),
                    _ShowcaseItem(
                      label: 'headingXs',
                      style: typography.headingXs,
                    ),
                    const Divider(height: 32),
                    _ShowcaseItem(label: 'bodyM', style: typography.bodyM),
                    _ShowcaseItem(label: 'bodyS', style: typography.bodyS),
                    const Divider(height: 32),
                    _ShowcaseItem(label: 'code', style: typography.code),
                    _ShowcaseItem(label: 'codeS', style: typography.codeS),
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

class _ShowcaseItem extends StatelessWidget {
  final String label;
  final TextStyle style;

  const _ShowcaseItem({required this.label, required this.style});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.cloudscapeSpacing.scaledM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.cloudscapeTypography.bodyS.copyWith(
              color: context.cloudscapeColors.tokens.colorTextBodySecondary,
            ),
          ),
          SizedBox(height: context.cloudscapeSpacing.scaledXxs),
          Text('The quick brown fox jumps over the lazy dog', style: style),
        ],
      ),
    );
  }
}

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

class UiKitExample extends StatefulWidget {
  const UiKitExample({super.key});

  @override
  State<UiKitExample> createState() => _UiKitExampleState();
}

class _UiKitExampleState extends State<UiKitExample> {
  // Configurable Alert State
  bool _configVisible = true;
  bool _configDismissible = false;

  // Anchor Navigation State
  String _activeAnchor = '#section-1.1';
  bool _group1Expanded = true;
  bool _group2Expanded = false;

  // Handlers
  void _resetConfig() {
    setState(() {
      _configVisible = true;
      _configDismissible = false;
    });
  }

  void _hideAlert() {
    setState(() {
      _configVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final typography = context.cloudscapeTypography;
    final spacing = context.cloudscapeSpacing;
    final colors = context.cloudscapeColors;
    final radius = context.cloudscapeRadius;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cloudscape Components Example',
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
            // Alert Component Card
            SizedBox(
              width: 600,
              child: CloudscapeBox(
                header: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: spacing.scaledM),
                  child: Text('Alert', style: typography.headingL),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Info', style: typography.headingS),
                    SizedBox(height: spacing.scaledXxs),
                    CloudscapeAlert(
                      type: AlertType.info,
                      header: const Text('Information'),
                      child: const Text(
                        'A message that provides context for the user without requiring them to act.',
                      ),
                    ),
                    SizedBox(height: spacing.scaledM),

                    Text('Success', style: typography.headingS),
                    SizedBox(height: spacing.scaledXxs),
                    CloudscapeAlert(
                      type: AlertType.success,
                      header: const Text('Success'),
                      child: const Text(
                        'Your action was completed successfully.',
                      ),
                    ),
                    SizedBox(height: spacing.scaledM),

                    Text('Warning', style: typography.headingS),
                    SizedBox(height: spacing.scaledXxs),
                    CloudscapeAlert(
                      type: AlertType.warning,
                      header: const Text('Warning'),
                      child: const Text(
                        'Please be careful before proceeding with this action.',
                      ),
                    ),
                    SizedBox(height: spacing.scaledM),

                    Text('Error', style: typography.headingS),
                    SizedBox(height: spacing.scaledXxs),
                    CloudscapeAlert(
                      type: AlertType.error,
                      header: const Text('Error'),
                      child: const Text(
                        'An error occurred while processing your request.',
                      ),
                    ),
                    SizedBox(height: spacing.scaledM),

                    Text('With button', style: typography.headingS),
                    SizedBox(height: spacing.scaledXxs),
                    CloudscapeAlert(
                      type: AlertType.info,
                      header: const Text('Updates available'),
                      action: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              colors.tokens.colorBackgroundButtonPrimaryDefault,
                          foregroundColor:
                              colors.tokens.colorTextButtonPrimaryDefault,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(radius.button),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('View updates'),
                      ),
                      child: const Text(
                        'There is a new version available for download.',
                      ),
                    ),
                    SizedBox(height: spacing.scaledXl),

                    const Divider(),
                    SizedBox(height: spacing.scaledM),

                    // Configuration Section
                    Text('Configuration', style: typography.headingM),
                    SizedBox(height: spacing.scaledM),

                    Container(
                      padding: EdgeInsets.all(spacing.scaledS),
                      decoration: BoxDecoration(
                        color: colors.tokens.colorBackgroundContainerContent,
                        border: Border.all(
                          color: colors.tokens.colorBorderItemFocused,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CloudscapeAlert(
                            type: AlertType.info,
                            header: const Text('Configurable alert'),
                            visible: _configVisible,
                            dismissible: _configDismissible,
                            onDismiss: _hideAlert,
                            child: const Text(
                              'Configure properties to see them applied to this alert.',
                            ),
                          ),
                          SizedBox(height: spacing.scaledM),
                          Text('Properties', style: typography.headingS),
                          SizedBox(height: spacing.scaledXs),
                          Row(
                            children: [
                              Text('dismissible', style: typography.bodyM),
                              Switch(
                                value: _configDismissible,
                                onChanged: (val) {
                                  setState(() {
                                    _configDismissible = val;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text('visible', style: typography.bodyM),
                              Switch(
                                value: _configVisible,
                                onChanged: (val) {
                                  setState(() {
                                    _configVisible = val;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: spacing.scaledM),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: OutlinedButton(
                              onPressed: _resetConfig,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: colors
                                      .tokens
                                      .colorBorderButtonNormalDefault,
                                ),
                                foregroundColor:
                                    colors.tokens.colorTextButtonNormalDefault,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    radius.button,
                                  ),
                                ),
                              ),
                              child: const Text('Reset'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Anchor Navigation Section - Variations
            SizedBox(
              width: 500,
              child: Column(
                children: [
                  // Variant 1: Default
                  CloudscapeBox(
                    header: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        horizontal: spacing.scaledM,
                      ),
                      child: Text(
                        'Anchor Navigation (Default)',
                        style: typography.headingL,
                      ),
                    ),
                    body: CloudscapeAnchorNavigation(
                      activeTargetId: _activeAnchor,
                      onFollow: (anchor) {
                        setState(() => _activeAnchor = anchor.targetId);
                      },
                      anchors: const [
                        AnchorNavigationItem(
                          text: 'Section 1',
                          targetId: 'section-1',
                        ),
                        AnchorNavigationItem(
                          text: 'Section 2',
                          targetId: 'section-2',
                        ),
                        AnchorNavigationItem(
                          text: 'Section 3',
                          targetId: 'section-3',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spacing.scaledM),

                  // Variant 2: With heading
                  CloudscapeBox(
                    header: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        horizontal: spacing.scaledM,
                      ),
                      child: Text('With heading', style: typography.headingL),
                    ),
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Page contents', style: typography.headingS),
                        const SizedBox(height: 8),
                        CloudscapeAnchorNavigation(
                          activeTargetId: _activeAnchor,
                          ariaLabelledby: 'Page contents',
                          onFollow: (anchor) =>
                              setState(() => _activeAnchor = anchor.targetId),
                          anchors: const [
                            AnchorNavigationItem(
                              text: 'Section 1',
                              targetId: 'section-1',
                            ),
                            AnchorNavigationItem(
                              text: 'Section 2',
                              targetId: 'section-2',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spacing.scaledM),

                  // Variant 3: With nested anchors & Status Labels
                  CloudscapeBox(
                    header: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        horizontal: spacing.scaledM,
                      ),
                      child: Text(
                        'With nested anchors & labels',
                        style: typography.headingL,
                      ),
                    ),
                    body: CloudscapeAnchorNavigation(
                      activeTargetId: _activeAnchor,
                      onFollow: (anchor) {
                        setState(() => _activeAnchor = anchor.targetId);
                      },
                      anchors: const [
                        AnchorNavigationItem(
                          text: 'Section 1',
                          targetId: 'section-1',
                          level: 1,
                        ),
                        AnchorNavigationItem(
                          text: 'Section 1.1',
                          targetId: 'section-1.1',
                          level: 2,
                        ),
                        AnchorNavigationItem(
                          text: 'Section 1.2',
                          targetId: 'section-1.2',
                          level: 2,
                          info: 'New',
                        ),
                        AnchorNavigationItem(
                          text: 'Section 2',
                          targetId: 'section-2',
                          level: 1,
                        ),
                        AnchorNavigationItem(
                          text: 'Section 2.1',
                          targetId: 'section-2.1',
                          level: 2,
                        ),
                        AnchorNavigationItem(
                          text: 'Section 2.2',
                          targetId: 'section-2.2',
                          level: 2,
                        ),
                        AnchorNavigationItem(
                          text: 'Section 2.2.1',
                          targetId: 'section-2.2.1',
                          level: 3,
                        ),
                        AnchorNavigationItem(
                          text: 'Section 3',
                          targetId: 'section-3',
                          level: 1,
                          info: 'Updated',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: spacing.scaledM),

                  // Variant 4: With Expandable Section & Without Grey Line
                  CloudscapeBox(
                    header: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        horizontal: spacing.scaledM,
                      ),
                      child: Text(
                        'With expandable section (no track)',
                        style: typography.headingL,
                      ),
                    ),
                    body: CloudscapeAnchorNavigation(
                      activeTargetId: _activeAnchor,
                      showTrack: false,
                      onFollow: (anchor) {
                        setState(() {
                          _activeAnchor = anchor.targetId;
                          if (anchor.targetId == 'group-1') {
                            _group1Expanded = !_group1Expanded;
                          } else if (anchor.targetId == 'group-2') {
                            _group2Expanded = !_group2Expanded;
                          }
                        });
                      },
                      anchors: [
                        AnchorNavigationItem(
                          text: 'Expandable Group 1',
                          targetId: 'group-1',
                          level: 1,
                          expanded: _group1Expanded,
                        ),
                        const AnchorNavigationItem(
                          text: 'Nested Section 1.1',
                          targetId: 'nested-1.1',
                          level: 2,
                        ),
                        const AnchorNavigationItem(
                          text: 'Nested Section 1.2',
                          targetId: 'nested-1.2',
                          level: 2,
                        ),
                        AnchorNavigationItem(
                          text: 'Expandable Group 2',
                          targetId: 'group-2',
                          level: 1,
                          expanded: _group2Expanded,
                        ),
                        const AnchorNavigationItem(
                          text: 'Nested Section 2.1',
                          targetId: 'nested-2.1',
                          level: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Typography Section
            SizedBox(
              width: 500,
              child: CloudscapeBox(
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
                    _ShowcaseItem(label: 'label', style: typography.label),
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

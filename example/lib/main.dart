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
          // Sample Theme Values:
          // You can customize colors and fonts dynamicly.
          theme: CloudscapeTheme.light(
            // brandColor: const Color.fromARGB(255, 148, 156, 26), // Brand Green
            // onBrandColor: Colors.white,
            // brandBackground: const Color(0xFFF2F3F5), // Light Gray background
            // brandText: const Color(0xFF16191F), // Dark Gray text
            // fontFamily: "Acme",
          ),
          darkTheme: CloudscapeTheme.dark(
            // brandColor: const Color.fromARGB(255, 148, 156, 26),
            // onBrandColor: Colors.white,
            // brandBackground: const Color(0xFF0F141A), // Deep Dark background
            // brandText: const Color(0xFFE9EBED), // Light Gray text
            // fontFamily: "Acme",
          ),
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
                  ? context.cloudscapeColors.backgrounds.containerContent
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

  // Anchor Navigation State
  String _activeAnchor = '#section-1.1';

  // Side Navigation State
  String _activeSideNav = 'alert';
  final Set<String> _expandedGroups = {'board-components'};

  final List<SideNavigationItem> _sideNavItems = [
    const SideNavigationItem(text: 'Alert', targetId: 'alert'),
    const SideNavigationItem(
      text: 'Anchor navigation',
      targetId: 'anchor-navigation',
    ),
    const SideNavigationItem(text: 'App layout', targetId: 'app-layout'),
    const SideNavigationItem(
      text: 'App layout toolbar',
      targetId: 'app-layout-toolbar',
    ),
    const SideNavigationItem(
      text: 'Attribute editor',
      targetId: 'attribute-editor',
    ),
    const SideNavigationItem(text: 'Autosuggest', targetId: 'autosuggest'),
    const SideNavigationItem(text: 'Badge', targetId: 'badge'),
    const SideNavigationItem(
      text: 'Board components',
      targetId: 'board-components',
      items: [
        SideNavigationItem(text: 'Board', targetId: 'board'),
        SideNavigationItem(text: 'Board item', targetId: 'board-item'),
        SideNavigationItem(text: 'Items palette', targetId: 'items-palette'),
      ],
    ),
    const SideNavigationItem(text: 'Box', targetId: 'box'),
    const SideNavigationItem(
      text: 'Breadcrumb group',
      targetId: 'breadcrumb-group',
    ),
  ];

  // Button Dropdown Configurator State
  bool _bddDisabled = false;
  bool _bddLoading = false;
  bool _bddFullWidth = false;
  bool _bddExpandable = false;

  final List<ButtonDropdownItemOrGroup> _bddItems = [
    const ButtonDropdownItem(id: 'delete', text: 'Delete'),
    const ButtonDropdownItem(id: 'move', text: 'Move'),
    const ButtonDropdownItem(
      id: 'rename',
      text: 'Rename',
      disabled: true,
      disabledReason: 'No permission to rename',
    ),
    const ButtonDropdownItem(
      id: 'view_metrics',
      text: 'View metrics',
      external: true,
    ),
  ];

  // Button Configurator State
  bool _btnDisabled = false;
  bool _btnLoading = false;
  bool _btnFullWidth = false;
  bool _btnWrapText = true;
  bool _btnExternal = false;

  // Breadcrumb Group State
  String _activeBreadcrumb = 'breadcrumb-group';

  final List<BreadcrumbItem> _breadcrumbItems = const [
    BreadcrumbItem(text: 'Home', href: 'home'),
    BreadcrumbItem(text: 'Components', href: 'components'),
    BreadcrumbItem(text: 'Breadcrumb group', href: 'breadcrumb-group'),
  ];

  // Input State
  String _inputValue = '';
  String _textareaValue = '';
  String _dateValue = '';
  String _timeValue = '';
  final List<String> _fileValues = [];
  bool _inputsDisabled = false;
  bool _inputsInvalid = false;
  bool _inputsReadOnly = false;

  // Selection State
  bool? _checkboxValue = false;
  bool _toggleValue = false;
  String? _radioValue = 'option_1';
  String? _tilesValue = 'option_1';
  SelectOption<String>? _selectValue;
  List<SelectOption<String>> _multiselectValue = [];
  bool _selectionDisabled = false;

  final List<SelectOption<String>> _dropdownOptions = const [
    SelectOption(value: '1', label: 'Option 1'),
    SelectOption(value: '2', label: 'Option 2', description: 'Secondary text'),
    SelectOption(value: '3', label: 'Option 3 (disabled)', disabled: true),
    SelectOption(value: '4', label: 'Option 4'),
    SelectOption(value: '5', label: 'Option 5'),
  ];

  @override
  Widget build(BuildContext context) {
    final typography = context.cloudscapeTypography;
    final spacing = context.cloudscapeSpacing;

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
                      action: CloudscapeButton(
                        variant: ButtonVariant.primary,
                        onPressed: () {},
                        text: 'View updates',
                      ),
                      child: const Text(
                        'There is a new version available for download.',
                      ),
                    ),
                    SizedBox(height: spacing.scaledXl),
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

                  // Side Navigation Showcase
                  CloudscapeBox(
                    header: Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        horizontal: spacing.scaledM,
                      ),
                      child: Text(
                        'Side Navigation',
                        style: typography.headingL,
                      ),
                    ),
                    body: SizedBox(
                      width: 250,
                      child: CloudscapeSideNavigation(
                        activeTargetId: _activeSideNav,
                        items: _sideNavItems
                            .map(
                              (item) => SideNavigationItem(
                                text: item.text,
                                targetId: item.targetId,
                                expanded: _expandedGroups.contains(
                                  item.targetId,
                                ),
                                items: item.items,
                              ),
                            )
                            .toList(),
                        onFollow: (item) {
                          setState(() => _activeSideNav = item.targetId);
                        },
                        onExpandToggle: (item) {
                          setState(() {
                            if (_expandedGroups.contains(item.targetId)) {
                              _expandedGroups.remove(item.targetId);
                            } else {
                              _expandedGroups.add(item.targetId);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Breadcrumb Group Showcase
            SizedBox(
              width: 500,
              child: CloudscapeBox(
                header: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: spacing.scaledM),
                  child: Text('Breadcrumb Group', style: typography.headingL),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Default', style: typography.headingS),
                    SizedBox(height: spacing.scaledXxs),
                    CloudscapeBreadcrumbGroup(
                      items: _breadcrumbItems,
                      onFollow: (item) {
                        setState(() {
                          _activeBreadcrumb = item.href;
                        });
                      },
                    ),
                    SizedBox(height: spacing.scaledM),
                    Text(
                      'Active breadcrumb: $_activeBreadcrumb',
                      style: typography.bodyS,
                    ),
                  ],
                ),
              ),
            ),

            // Button Dropdown Showcase
            SizedBox(
              width: 500,
              child: CloudscapeBox(
                header: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: spacing.scaledM),
                  child: Text(
                    'Button Dropdown Showcase',
                    style: typography.headingL,
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Examples', style: typography.headingM),
                    SizedBox(height: spacing.scaledS),
                    Wrap(
                      spacing: spacing.scaledS,
                      runSpacing: spacing.scaledS,
                      children: [
                        CloudscapeButtonDropdown(
                          text: 'Short',
                          items: _bddItems,
                          disabled: _bddDisabled,
                          loading: _bddLoading,
                          fullWidth: _bddFullWidth,
                          expandableGroups: _bddExpandable,
                        ),
                        CloudscapeButtonDropdown(
                          text: 'Primary dropdown',
                          variant: ButtonVariant.primary,
                          items: _bddItems,
                          disabled: _bddDisabled,
                          loading: _bddLoading,
                          expandableGroups: _bddExpandable,
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    Text('Configuration', style: typography.headingM),
                    SizedBox(height: spacing.scaledS),
                    Column(
                      children: [
                        CheckboxListTile(
                          title: const Text('disabled'),
                          value: _bddDisabled,
                          onChanged: (v) => setState(() => _bddDisabled = v!),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                        CheckboxListTile(
                          title: const Text('loading'),
                          value: _bddLoading,
                          onChanged: (v) => setState(() => _bddLoading = v!),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                        CheckboxListTile(
                          title: const Text('fullWidth'),
                          value: _bddFullWidth,
                          onChanged: (v) => setState(() => _bddFullWidth = v!),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                        CheckboxListTile(
                          title: const Text('expandableGroups'),
                          value: _bddExpandable,
                          onChanged: (v) => setState(() => _bddExpandable = v!),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Button Showcase
            SizedBox(
              width: 500,
              child: CloudscapeBox(
                header: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: spacing.scaledM),
                  child: Text('Button Showcase', style: typography.headingL),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Examples', style: typography.headingM),
                    SizedBox(height: spacing.scaledS),
                    Wrap(
                      spacing: spacing.scaledS,
                      runSpacing: spacing.scaledS,
                      children: [
                        CloudscapeButton(
                          text: 'Primary button',
                          variant: ButtonVariant.primary,
                          disabled: _btnDisabled,
                          loading: _btnLoading,
                          fullWidth: _btnFullWidth,
                          wrapText: _btnWrapText,
                          external: _btnExternal,
                          onPressed: () {},
                        ),
                        CloudscapeButton(
                          text: 'Normal button',
                          variant: ButtonVariant.normal,
                          disabled: _btnDisabled,
                          loading: _btnLoading,
                          fullWidth: _btnFullWidth,
                          wrapText: _btnWrapText,
                          external: _btnExternal,
                          onPressed: () {},
                        ),
                        CloudscapeButton(
                          text: 'Link button',
                          variant: ButtonVariant.link,
                          disabled: _btnDisabled,
                          loading: _btnLoading,
                          fullWidth: _btnFullWidth,
                          wrapText: _btnWrapText,
                          external: _btnExternal,
                          onPressed: () {},
                        ),
                        CloudscapeButton(
                          variant: ButtonVariant.icon,
                          iconName: Icons.settings,
                          disabled: _btnDisabled,
                          loading: _btnLoading,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    Text('Configuration', style: typography.headingM),
                    SizedBox(height: spacing.scaledS),
                    Column(
                      children: [
                        CheckboxListTile(
                          title: const Text('disabled'),
                          value: _btnDisabled,
                          onChanged: (v) => setState(() => _btnDisabled = v!),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                        CheckboxListTile(
                          title: const Text('loading'),
                          value: _btnLoading,
                          onChanged: (v) => setState(() => _btnLoading = v!),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                        CheckboxListTile(
                          title: const Text('fullWidth'),
                          value: _btnFullWidth,
                          onChanged: (v) => setState(() => _btnFullWidth = v!),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                        CheckboxListTile(
                          title: const Text('wrapText'),
                          value: _btnWrapText,
                          onChanged: (v) => setState(() => _btnWrapText = v!),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                        CheckboxListTile(
                          title: const Text('external'),
                          value: _btnExternal,
                          onChanged: (v) => setState(() => _btnExternal = v!),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ],
                    ),
                  ],
                ),
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

            // Input Components Showcase
            SizedBox(
              width: 500,
              child: CloudscapeBox(
                header: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: spacing.scaledM),
                  child: Text('Input Components', style: typography.headingL),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Examples', style: typography.headingM),
                    SizedBox(height: spacing.scaledS),

                    Text('Text Input', style: typography.headingS),
                    SizedBox(height: spacing.scaledXxs),
                    CloudscapeInput(
                      value: _inputValue,
                      onChange: (v) => setState(() => _inputValue = v),
                      placeholder: 'Enter text...',
                      disabled: _inputsDisabled,
                      readOnly: _inputsReadOnly,
                      invalid: _inputsInvalid,
                      clearable: true,
                    ),
                    SizedBox(height: spacing.scaledM),

                    Text('Textarea', style: typography.headingS),
                    SizedBox(height: spacing.scaledXxs),
                    CloudscapeTextarea(
                      value: _textareaValue,
                      onChange: (v) => setState(() => _textareaValue = v),
                      placeholder: 'Enter multiline text...',
                      disabled: _inputsDisabled,
                      readOnly: _inputsReadOnly,
                      invalid: _inputsInvalid,
                    ),
                    SizedBox(height: spacing.scaledM),

                    Text('Date Input', style: typography.headingS),
                    SizedBox(height: spacing.scaledXxs),
                    CloudscapeDateInput(
                      value: _dateValue,
                      onChange: (v) => setState(() => _dateValue = v),
                      disabled: _inputsDisabled,
                      readOnly: _inputsReadOnly,
                      invalid: _inputsInvalid,
                    ),
                    SizedBox(height: spacing.scaledM),

                    Text('Time Input', style: typography.headingS),
                    SizedBox(height: spacing.scaledXxs),
                    CloudscapeTimeInput(
                      value: _timeValue,
                      onChange: (v) => setState(() => _timeValue = v),
                      disabled: _inputsDisabled,
                      readOnly: _inputsReadOnly,
                      invalid: _inputsInvalid,
                    ),
                    SizedBox(height: spacing.scaledM),

                    Text('File Input', style: typography.headingS),
                    SizedBox(height: spacing.scaledXxs),
                    CloudscapeFileInput(
                      values: _fileValues,
                      disabled: _inputsDisabled,
                      onChoosePressed: () {
                        setState(() {
                          _fileValues.add(
                            'document_v${_fileValues.length + 1}.pdf',
                          );
                        });
                      },
                      onRemovePressed: (index) {
                        setState(() {
                          _fileValues.removeAt(index);
                        });
                      },
                    ),

                    const Divider(height: 32),
                    Text('Configuration', style: typography.headingM),
                    SizedBox(height: spacing.scaledS),
                    Column(
                      children: [
                        CheckboxListTile(
                          title: const Text('disabled'),
                          value: _inputsDisabled,
                          onChanged: (v) =>
                              setState(() => _inputsDisabled = v!),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                        CheckboxListTile(
                          title: const Text('readOnly'),
                          value: _inputsReadOnly,
                          onChanged: (v) =>
                              setState(() => _inputsReadOnly = v!),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                        CheckboxListTile(
                          title: const Text('invalid'),
                          value: _inputsInvalid,
                          onChanged: (v) => setState(() => _inputsInvalid = v!),
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Selection Components Showcase
            SizedBox(
              width: 500,
              child: CloudscapeBox(
                header: Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: spacing.scaledM),
                  child: Text(
                    'Selection Components',
                    style: typography.headingL,
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Examples', style: typography.headingM),
                    SizedBox(height: spacing.scaledS),

                    Text('Checkbox', style: typography.headingS),
                    SizedBox(height: spacing.scaledXxs),
                    CloudscapeCheckbox(
                      checked: _checkboxValue,
                      onChange: (v) => setState(() => _checkboxValue = v),
                      text: 'I agree to the terms',
                      description: 'You must agree before continuing',
                      disabled: _selectionDisabled,
                    ),
                    SizedBox(height: spacing.scaledM),

                    Text('Toggle', style: typography.headingS),
                    SizedBox(height: spacing.scaledXxs),
                    CloudscapeToggle(
                      checked: _toggleValue,
                      onChange: (v) => setState(() => _toggleValue = v),
                      text: 'Enable weekly digest',
                      description: 'Provides a summary of last week’s activity',
                      disabled: _selectionDisabled,
                    ),
                    SizedBox(height: spacing.scaledM),

                    Text('Radio Group', style: typography.headingS),
                    SizedBox(height: spacing.scaledXxs),
                    CloudscapeRadioGroup<String>(
                      value: _radioValue,
                      onChange: (v) => setState(() => _radioValue = v),
                      disabled: _selectionDisabled,
                      items: [
                        CloudscapeRadioGroupItem(
                          value: 'option_1',
                          text: 'Option 1',
                          description: 'This is the first option',
                        ),
                        CloudscapeRadioGroupItem(
                          value: 'option_2',
                          text: 'Option 2',
                          description: 'This is the second option',
                        ),
                        CloudscapeRadioGroupItem(
                          value: 'option_3',
                          text: 'Option 3',
                          description: 'This is the third option (disabled)',
                          disabled: true,
                        ),
                      ],
                    ),
                    SizedBox(height: spacing.scaledM),

                    Text('Tiles', style: typography.headingS),
                    SizedBox(height: spacing.scaledXxs),
                    CloudscapeTiles<String>(
                      value: _tilesValue,
                      onChange: (v) => setState(() => _tilesValue = v),
                      disabled: _selectionDisabled,
                      columns: 2,
                      items: const [
                        CloudscapeTileItem(
                          value: 'option_1',
                          label: 'Item 1',
                          description: 'First option description',
                        ),
                        CloudscapeTileItem(
                          value: 'option_2',
                          label: 'Item 2',
                          description: 'Second option description',
                        ),
                      ],
                    ),
                    SizedBox(height: spacing.scaledM),

                    Text('Select', style: typography.headingS),
                    SizedBox(height: spacing.scaledXxs),
                    CloudscapeSelect<String>(
                      options: _dropdownOptions,
                      selectedOption: _selectValue,
                      onChange: (v) => setState(() => _selectValue = v),
                      placeholder: 'Choose an option',
                      disabled: _selectionDisabled,
                    ),
                    SizedBox(height: spacing.scaledM),

                    Text('Multiselect', style: typography.headingS),
                    SizedBox(height: spacing.scaledXxs),
                    CloudscapeMultiselect<String>(
                      options: _dropdownOptions,
                      selectedOptions: _multiselectValue,
                      onChange: (v) => setState(() => _multiselectValue = v),
                      placeholder: 'Choose options',
                      disabled: _selectionDisabled,
                      deselectAllText: 'Clear selection',
                    ),

                    const Divider(height: 32),
                    Text('Configuration', style: typography.headingM),
                    SizedBox(height: spacing.scaledS),
                    CheckboxListTile(
                      title: const Text('disabled'),
                      value: _selectionDisabled,
                      onChanged: (v) => setState(() => _selectionDisabled = v!),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
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
              color: context.cloudscapeColors.text.bodySecondary,
            ),
          ),
          SizedBox(height: context.cloudscapeSpacing.scaledXxs),
          Text('The quick brown fox jumps over the lazy dog', style: style),
        ],
      ),
    );
  }
}

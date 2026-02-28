import 'package:flutter_test/flutter_test.dart';
import 'package:cloudscape_flutter_uikit/cloudscape_flutter_uikit.dart';

void main() {
  test('CloudscapeTheme tokens are correctly initialized', () {
    final lightColors = CloudscapeColors.light();
    final darkColors = CloudscapeColors.dark();

    expect(lightColors.backgroundMain, CloudscapePalette.white);
    expect(darkColors.backgroundMain, CloudscapePalette.black);
    expect(CloudscapeSpacing.medium, 16.0);
  });
}

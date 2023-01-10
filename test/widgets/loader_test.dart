import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysteres/components/color_palette.dart';
import 'package:mysteres/widgets/loader.dart';

void main() {
  testWidgets('Circular Progress Indicator is displayed', (tester) async {
    await tester.pumpWidget(const Loader(
        strokeWidth: 15,
        backgroundColor: ColorPalette.primary,
        color: ColorPalette.primaryDark));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}

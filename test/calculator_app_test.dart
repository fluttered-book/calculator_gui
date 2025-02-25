// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:calculator_gui/app.dart';
import 'package:calculator_gui/widgets/calculator_button.dart';
import 'package:calculator_gui/widgets/calculator_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('"↲" enters/adds a number to the stack',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(CalculatorApp());

    await tester.tapButton('5');
    await tester.tapButton('↲');

    expect(find.inputText(), equals(''));
    expect(find.stackText(), equals('5.0'));
  });

  testWidgets('"C" clears input and stack', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(CalculatorApp());

    await tester.enterNumber('24');
    await tester.tapButton('7');
    await tester.tapButton('C');

    expect(find.inputText(), equals(''));
    expect(find.stackText(), equals(''));
  });

  testWidgets('"⌫" removes last input digit', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(CalculatorApp());

    await tester.tapButton('1');
    await tester.tapButton('5');
    await tester.tapButton('⌫');

    expect(find.inputText(), equals('1'));
  });

  testWidgets('"↩" will undo last command', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(CalculatorApp());

    await tester.enterNumber('9');
    await tester.tapButton('↩');

    expect(find.stackText(), equals(''));
  });

  testWidgets('15 3 / = 5', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(CalculatorApp());

    await tester.enterNumber('15');
    await tester.enterNumber('3');
    await tester.tapButton('÷');

    expect(find.stackText(), equals('5.0'));
  });

  testWidgets('5 3 * = 15', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(CalculatorApp());

    await tester.enterNumber('5');
    await tester.enterNumber('3');
    await tester.tapButton('✕');

    expect(find.stackText(), equals('15.0'));
  });

  testWidgets('7 2 - = 5', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(CalculatorApp());

    await tester.enterNumber('7');
    await tester.enterNumber('2');
    await tester.tapButton('-');

    expect(find.stackText(), equals('5.0'));
  });

  testWidgets('2 2 + = 4', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(CalculatorApp());

    await tester.enterNumber('2');
    await tester.enterNumber('2');
    await tester.tapButton('+');

    expect(find.stackText(), equals('4.0'));
  });
}

extension on CommonFinders {
  String? inputText() {
    final textWidget = find
        .descendant(
          of: find.byType(CalculatorDisplay),
          matching: find.byKey(
            ValueKey('input'),
          ),
        )
        .evaluate()
        .single
        .widget as Text;
    return textWidget.data;
  }

  String? stackText() {
    final textWidget = find
        .descendant(
          of: find.byType(CalculatorDisplay),
          matching: find.byKey(
            ValueKey('stack'),
          ),
        )
        .evaluate()
        .single
        .widget as Text;
    return textWidget.data;
  }
}

extension on WidgetTester {
  Future<void> tapButton(String text) async {
    await tap(find.widgetWithText(CalculatorButton, text));
    await pump();
  }

  Future<void> enterNumber(String digits) async {
    for (final digit in digits.characters) {
      await tapButton(digit);
    }
    await tapButton('↲');
  }
}

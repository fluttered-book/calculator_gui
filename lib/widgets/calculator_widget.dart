import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/commands.dart';
import '../core/calculator_state.dart';
import 'calculator_button.dart';
import 'calculator_display.dart';

typedef ButtonDef = (String, void Function()?);

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({super.key});

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  late List<List<ButtonDef>> buttons;
  late CalculatorState calculatorState;

  void Function() on(Command command) {
    return () {
      setState(() {
        if (kDebugMode) debugPrint("Old state: $calculatorState}");

        calculatorState = command.execute(calculatorState);

        if (kDebugMode) {
          debugPrint("New state: $calculatorState}");
          debugPrint("---");
        }
      });
    };
  }

  @override
  void initState() {
    super.initState();
    buttons = [
      [
        ("C", on(Clear())),
        ("⌫", on(Remove())),
        ("↩", on(Undo())),
        ('÷', on(Divide()))
      ],
      [
        ('7', on(Append('7'))),
        ('8', on(Append('8'))),
        ('9', on(Append('9'))),
        ('✕', on(Multiply()))
      ],
      [
        ('4', on(Append('4'))),
        ('5', on(Append('5'))),
        ('6', on(Append('6'))),
        ('-', on(Subtract()))
      ],
      [
        ('1', on(Append('1'))),
        ('2', on(Append('2'))),
        ('3', on(Append('3'))),
        ('+', on(Add()))
      ],
      [
        ('0', on(Append('0'))),
        ('.', on(Append('.'))),
        (' ', null),
        ("↲", on(Enter()))
      ],
    ];
    calculatorState = CalculatorState.empty();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          flex: 2,
          child: CalculatorDisplay(state: calculatorState),
        ),
        for (final (rowIndex, row) in buttons.indexed)
          Flexible(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final (colIndex, btn) in row.indexed)
                  Expanded(
                    flex: 1,
                    child: CalculatorButton(
                      btn,
                      rowIndex: rowIndex,
                      colIndex: colIndex,
                    ),
                  ),
              ],
            ),
          )
      ],
    );
  }
}

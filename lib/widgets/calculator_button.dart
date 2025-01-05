import 'package:flutter/material.dart';

import 'calculator_widget.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton(this.definition,
      {super.key, required this.rowIndex, required this.colIndex});

  final ButtonDef definition;
  final int rowIndex;
  final int colIndex;

  @override
  Widget build(BuildContext context) {
    if (definition.$1.trim().isEmpty) return const SizedBox();

    TextStyle style;
    if (colIndex == 3) {
      style = TextStyle(fontSize: 36, color: Colors.lightBlueAccent);
    } else if (rowIndex == 0) {
      style = TextStyle(fontSize: 24, color: Colors.grey);
    } else {
      style = TextStyle(fontSize: 24, color: Colors.white);
    }

    return TextButton(
      onPressed: definition.$2,
      child: Text(definition.$1, style: style),
    );
  }
}

import 'package:flutter/material.dart';

import '../core/calculator_state.dart';

class CalculatorDisplay extends StatelessWidget {
  const CalculatorDisplay({super.key, required this.state});

  final CalculatorState state;

  get stack => state.stack;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  state.input,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  state.stack.join(', '),
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

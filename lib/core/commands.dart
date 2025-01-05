import 'package:flutter/widgets.dart';

import 'internal_state.dart';

/// Abstract base class for all calculator operations
abstract class Command {
  InternalState apply(InternalState state);
}

class Enter implements Command {
  @override
  InternalState apply(InternalState state) {
    final number = double.tryParse(state.input);
    if (number == null) return state;
    return InternalState(
      input: "",
      stack: [...state.stack, number],
      history: [...state.history, state.stack],
    );
  }
}

class Clear implements Command {
  @override
  InternalState apply(InternalState state) {
    return InternalState.empty();
  }
}

class Undo extends Command {
  @override
  InternalState apply(InternalState state) {
    if (state.history.isEmpty) return state;
    return InternalState(
      input: state.input,
      stack: state.history.last,
      history: [...state.history.take(state.history.length - 1)],
    );
  }
}

class Append extends Command {
  Append(this.digit);

  final String digit;

  @override
  InternalState apply(InternalState state) {
    final number = double.tryParse(state.input + digit.toString());
    if (number == null) return state;
    return InternalState(
      input: state.input + digit.toString(),
      stack: state.stack,
      history: [...state.history, state.stack],
    );
  }
}

class Remove extends Command {
  @override
  InternalState apply(InternalState state) {
    if (state.input.isEmpty) return state;
    return InternalState(
      input: state.input.characters.take(state.input.length - 1).toString(),
      stack: state.stack,
      history: state.history,
    );
  }
}

/// Operators (+, -, /, *) should use this as base class to avoid duplication
abstract class Operator implements Command {
  late num operand1;
  late num operand2;

  num operate(num operand1, num operand2);

  @override
  InternalState apply(InternalState state) {
    if (state.stack.length < 2) return state;
    operand2 = state.stack.last;
    operand1 = state.stack.last;
    return InternalState(
      input: state.input,
      stack: [
        ...state.stack.take(state.stack.length - 2),
        operate(operand1, operand2)
      ],
      history: [...state.history, state.stack],
    );
  }

  @override
  InternalState unapply(InternalState state) {
    return InternalState(
      input: state.input,
      stack: [...state.stack.take(state.stack.length - 1), operand1, operand2],
      history: state.history.take(state.history.length - 1).toList(),
    );
  }
}

class Add extends Operator {
  @override
  num operate(num operand1, num operand2) => operand1 + operand2;
}

class Subtract extends Operator {
  @override
  num operate(num operand1, num operand2) => operand1 - operand2;
}

class Multiply extends Operator {
  @override
  num operate(num operand1, num operand2) => operand1 * operand2;
}

class Divide extends Operator {
  @override
  num operate(num operand1, num operand2) => operand1 / operand2;
}

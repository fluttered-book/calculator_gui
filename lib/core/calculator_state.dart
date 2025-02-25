class CalculatorState {
  CalculatorState({
    required this.input,
    required this.stack,
    required this.history,
  });

  static CalculatorState empty() =>
      CalculatorState(input: "", stack: [], history: []);

  final List<num> stack;
  final List<List<num>> history;
  final String input;

  @override
  String toString() {
    return "{input: $input, stack: $stack, history: $history}";
  }
}

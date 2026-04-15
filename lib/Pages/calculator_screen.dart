import '../core.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = '';

  void press(String value) {
    setState(() {
      if (value == 'C') {
        output = '';
      } else if (value == '=') {
        try {
          Parser p = Parser();
          Expression exp = p.parse(output);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);

          output = eval.toString();
        } catch (_) {
          output = 'Error';
        }
      } else {
        output += value;
      }
    });
  }

  Widget button(String text) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: () => press(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(text, style: const TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(20),
            child: Text(
              output,
              style: TextStyle(
                fontSize: 32,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          Column(
            children: [
              Row(children: [button('7'), button('8'), button('9'), button('/')]),
              Row(children: [button('4'), button('5'), button('6'), button('*')]),
              Row(children: [button('1'), button('2'), button('3'), button('-')]),
              Row(children: [button('0'), button('C'), button('='), button('+')]),
            ],
          )
        ],
      ),
    );
  }
}
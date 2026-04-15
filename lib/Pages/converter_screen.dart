import '../core.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final controller = TextEditingController();
  double result = 0;

  String fromUnit = 'Meters';
  String toUnit = 'Kilometers';

  void convert() {
    final value = double.tryParse(controller.text) ?? 0;

    setState(() {
      if (fromUnit == 'Meters' && toUnit == 'Kilometers') {
        result = value / 1000;
      } else if (fromUnit == 'Kilometers' && toUnit == 'Meters') {
        result = value * 1000;
      } else {
        result = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Unit Converter'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter value',
                filled: true,
                fillColor: colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: fromUnit,
                  items: const [
                    DropdownMenuItem(value: 'Meters', child: Text('Meters')),
                    DropdownMenuItem(value: 'Kilometers', child: Text('Kilometers')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      fromUnit = value!;
                    });
                  },
                ),

                const Icon(Icons.swap_horiz),

                DropdownButton<String>(
                  value: toUnit,
                  items: const [
                    DropdownMenuItem(value: 'Meters', child: Text('Meters')),
                    DropdownMenuItem(value: 'Kilometers', child: Text('Kilometers')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      toUnit = value!;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: convert,
              child: const Text('Convert'),
            ),

            const SizedBox(height: 20),

            Text(
              'Result: $result $toUnit',
              style: TextStyle(
                fontSize: 20,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
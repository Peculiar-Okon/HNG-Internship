import '../core.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class Expense {
  final double amount;
  final String description;
  final DateTime date;

  Expense({
    required this.amount,
    required this.description,
    required this.date,
  });
}

class _BudgetScreenState extends State<BudgetScreen> {
  List<Expense> expenses = [];

  final amountController = TextEditingController();
  final descController = TextEditingController();

  double get total =>
      expenses.fold(0, (sum, item) => sum + item.amount);

  void addExpense() {
    final amount = double.tryParse(amountController.text);
    final description = descController.text.trim();

    if (amount == null || description.isEmpty) return;

    setState(() {
      expenses.add(
        Expense(
          amount: amount,
          description: description,
          date: DateTime.now(),
        ),
      );

      amountController.clear();
      descController.clear();
    });
  }

  void deleteExpense(int index) {
    setState(() {
      expenses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Budget Tracker'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme.primary,
        onPressed: addExpense,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              color: colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text('Total Spending'),
                    Text(
                      '₦${total.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 28,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: descController,
              decoration: InputDecoration(
                hintText: 'What did you spend on?',
                filled: true,
                fillColor: colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Amount',
                filled: true,
                fillColor: colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (_, i) {
                  final expense = expenses[i];

                  return Card(
                    color: colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(
                        '₦${expense.amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        expense.description,
                        style: TextStyle(
                          color: colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteExpense(i),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import '../core.dart';

// class BudgetScreen extends StatefulWidget {
//   const BudgetScreen({super.key});

//   @override
//   State<BudgetScreen> createState() => _BudgetScreenState();
// }

// class _BudgetScreenState extends State<BudgetScreen> {
//   List<double> expenses = [];
//   final controller = TextEditingController();

//   double get total => expenses.fold(0, (a, b) => a + b);

//   void addExpense() {
//     final value = double.tryParse(controller.text);
//     if (value == null) return;
//     setState(() {
//       expenses.add(value);
//       controller.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: const Text('Budget Tracker'),
//         backgroundColor: colorScheme.surface,
//         foregroundColor: colorScheme.onSurface,
//         elevation: 0,
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: colorScheme.primary,
//         onPressed: addExpense,
//         child: const Icon(Icons.add),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Card(
//               color: colorScheme.surface,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   children: [
//                     const Text('Total Spending'),
//                     Text(
//                       '₦${total.toStringAsFixed(2)}',
//                       style: TextStyle(
//                         fontSize: 28,
//                         color: colorScheme.onSurface,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: controller,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 hintText: 'Enter amount',
//                 filled: true,
//                 fillColor: colorScheme.surface,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: expenses.length,
//                 itemBuilder: (_, i) => ListTile(
//                   leading: const Icon(Icons.money),
//                   title: Text(
//                     '₦${expenses[i]}',
//                     style: TextStyle(color: colorScheme.onSurface),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


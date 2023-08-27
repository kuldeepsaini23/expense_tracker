import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.study,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.fun,
    ),
  ];

  void _openAddExpenseOverlay() {
    //Add button functionality
    showModalBottomSheet(
      useSafeArea: true, //Section 6
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    //*clear all snackbar before hitting newone
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Delete"),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //*Width
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "No expense found. Start adding some",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton.icon(
          onPressed: _openAddExpenseOverlay,
          icon: const Icon(Icons.add),
          label: const Text("Add Expense"),
        )
      ],
    ));

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
        // backgroundColor: Colors.purple,
      ),
      body: width < 600
          ? Column(
              children: [
                _registeredExpenses.isNotEmpty
                    ? Chart(expenses: _registeredExpenses)
                    : const SizedBox(
                        height: 0,
                      ),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: _registeredExpenses.isNotEmpty
                      ? Chart(expenses: _registeredExpenses)
                      : const SizedBox(
                          height: 1,
                        ),
                ),
                Expanded(
                  child: mainContent,
                )
              ],
            ),
    );
  }
}

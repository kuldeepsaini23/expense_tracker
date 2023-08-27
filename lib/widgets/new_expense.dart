import 'dart:io';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
//* Method 1 to mange input
  // var _enteredTitle = '';

  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }

//* Method 2
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // Date Picker function
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    // showDatePicker(
    //     context: context,
    //     initialDate: now,
    //     firstDate: firstDate,
    //     lastDate: now,
    //   ).then((value) => null);

    //* Async and Await
    var pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      //for ios
      showCupertinoDialog(
        context: context,
        builder: ((ctx) => CupertinoAlertDialog(
              title: Text(
                "Invalid Input",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              content: Text(
                "Please make sure a valid title, amount, date amd category was entered.",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("Okay"),
                ),
              ],
            )),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            "Invalid Input",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            "Please make sure a valid title, amount, date amd category was entered.",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseData() async {
    final enteredAmount = double.tryParse(_amountController.text);
    //try parse('hello) ==> null, tryparse('1.21') => 1.21
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }

    final newExpense = Expense(
      title: _titleController.text,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    );

    // Trigger the callback to update the expenses list in the parent widget
    widget.onAddExpense(newExpense);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                Text(
                  "Add Expense",
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                if (width > 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //* Title Input
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text("Title"),
                          ),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),

                      const SizedBox(
                        width: 24,
                      ),

                      //*Amount Input
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: "₹ ",
                            label: Text("Amount"),
                          ),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  )
                else
                  //* Title Input
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text("Title"),
                    ),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),

                if (width < 600)
                  //*Amount Input
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: "₹ ",
                      label: Text("Amount"),
                    ),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),

                const SizedBox(
                  height: 30,
                ),

                //*Dropdown and Date selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //* Amount Input
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                                style: Theme.of(context).textTheme.titleLarge,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),

                    const SizedBox(
                      width: 8,
                    ),

                    //* Date Picker
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? "Selected Date"
                                : formatter.format(_selectedDate!),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),

                          //* Calender Button
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month_outlined),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),

                //* Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //*Cancel button
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    //* Save Button
                    ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text("Save Expense"))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

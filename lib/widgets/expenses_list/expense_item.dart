import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //*Expense Title
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                //*Expense Amount
                Text(
                  '₹ ${expense.amount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                Row(
                  //*Expense Catrgory Icon and Date
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 7,),
                    Text(
                      expense.formattedDate,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

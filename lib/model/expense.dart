import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

//* Enum
enum Category {
  food,
  travel,
  clothes,
  fun,
  memberships,
  study,
  recharge,
  personalCare,
  pets,
  utilties,
  games,
  miscellaneous
}

const categoryIcons = {
  Category.food : Icons.lunch_dining,
  Category.travel : Icons.map_outlined,
  Category.clothes : Icons.checkroom_outlined,
  Category.fun : Icons.celebration,
  Category.memberships : Icons.card_membership_outlined,
  Category.study : Icons.book_outlined,
  Category.recharge : Icons.mobile_friendly,
  Category.personalCare : Icons.hive_rounded,
  Category.pets : Icons.pets_outlined,
  Category.utilties : Icons.work_outline,
  Category.games : Icons.games_outlined,
  Category.miscellaneous : Icons.question_mark_rounded,
};


class Expense {
  //Constructor function to take these values
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  //* Id for an expense and dono not take this as an input I wanna generate unique id evey time I get an input of these all values
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate{
    return formatter.format(date);
  }

  static fromJson(String expenseJson) {}
}

//* Class for Chart
class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; // sum = sum + expense.amount
    }

    return sum;
  }
}
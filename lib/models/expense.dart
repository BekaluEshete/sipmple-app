import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Catigory { food, travel, leisure, work }

const catigoryIcons = {
  Catigory.food: Icons.lunch_dining,
  Catigory.travel: Icons.flight_takeoff,
  Catigory.leisure: Icons.movie,
  Catigory.work: Icons.work
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.catigory})
      : id = uuid.v4();
  final String title;
  final double amount;
  final DateTime date;
  final String id;
  final Catigory catigory;
  String get formated {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.catagory, required this.expenses});
  final Catigory catagory;
  final List<Expense> expenses;
  ExpenseBucket.forCatigory(List<Expense> allExpense, this.catagory)
      : expenses = allExpense
            .where((expense) => expense.catigory == catagory)
            .toList();

  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}

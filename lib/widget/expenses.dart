import 'package:flutter/material.dart';
import 'package:interact/models/expense.dart';
import 'package:interact/widget/expense_list.dart';
import 'package:interact/widget/new_expensea.dart';
import 'package:interact/widget/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _customExpences = [
    Expense(
        title: "Flutter Course",
        amount: 13.4,
        date: DateTime.now(),
        catigory: Catigory.work),
    Expense(
        title: "Leisure",
        amount: 13.5,
        date: DateTime.now(),
        catigory: Catigory.leisure),
    Expense(
        title: "Food",
        amount: 33.4,
        date: DateTime.now(),
        catigory: Catigory.food),
    Expense(
        title: "Travel",
        amount: 37.4,
        date: DateTime.now(),
        catigory: Catigory.travel),
  ];
  void _modalBottmSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: ((ctx) => NewExpense(
              onAddItem: _addExpense,
            )));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _customExpences.add(expense);
    });
  }

  void _removeExpence(Expense expense) {
    final expenseIndex = _customExpences.indexOf(expense);
    setState(() {
      _customExpences.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense deleted"),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _customExpences.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget maincontent = const Center(
      child: Text('there is no expence please add some!'),
    );
    if (_customExpences.isNotEmpty) {
      maincontent = ExpenseList(
        list: _customExpences,
        onRemoveItem: _removeExpence,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("The cunsumtion of this month"),
        actions: [
          IconButton(onPressed: _modalBottmSheet, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Chart(expenses: _customExpences),
          Expanded(child: maincontent)
        ],
      ),
    );
  }
}

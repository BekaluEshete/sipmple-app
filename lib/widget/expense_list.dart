import 'package:flutter/material.dart';
import 'package:interact/models/expense.dart';
import 'package:interact/widget/expense_item.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.list, required this.onRemoveItem});
  final List<Expense> list;
  final void Function(Expense expense) onRemoveItem;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(list[index]),
            background: Container(
              color: Theme.of(context).colorScheme.error,
              margin: EdgeInsets.symmetric(
                  horizontal: Theme.of(context).cardTheme.margin!.horizontal),
            ),
            onDismissed: (direction) => {onRemoveItem(list[index])},
            child: ExpenseItem(list[index])));
  }
}

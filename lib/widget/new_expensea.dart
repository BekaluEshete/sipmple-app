import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:interact/models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddItem});
  final void Function(Expense expense) onAddItem;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  Catigory _selectedItem = Catigory.leisure;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  void _percentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 10, now.month, now.day);
    final pikedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    if (pikedDate != null) {
      setState(() {
        _selectedDate = pikedDate;
      });
    }
  }

  void _submitExpenseDate() {
    final enteredAmount = double.tryParse(_amountcontroller.text);
    final amountIsValid = enteredAmount == null || enteredAmount <= 0;
    if (_titlecontroller.text.trim().isEmpty ||
        amountIsValid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("invalid input"),
          content: const Text(
              "please make sure u enterd the valid date, amount and title"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("okey"),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddItem(
      Expense(
        title: _titlecontroller.text,
        amount: enteredAmount,
        date: _selectedDate!,
        catigory: _selectedItem,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final KeyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, 48, 16, KeyboardSpace + 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titlecontroller,
                          maxLength: 50,
                          decoration:
                              const InputDecoration(label: Text('Titles')),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextField(
                          controller: _amountcontroller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: "\$ ",
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      TextField(
                        controller: _titlecontroller,
                        maxLength: 50,
                        decoration:
                            const InputDecoration(label: Text('Titles')),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _amountcontroller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: "\$ ",
                          label: Text('Amount'),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton(
                        value: _selectedItem,
                        items: Catigory.values.map((catogory) {
                          return DropdownMenuItem(
                            value: catogory,
                            child: Text(catogory.name.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedItem = value;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              _selectedDate == null
                                  ? 'not date Selected'
                                  : formatter.format(_selectedDate!),
                            ),
                          ),
                          IconButton(
                            onPressed: _percentDatePicker,
                            icon: const Icon(Icons.calendar_month),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseDate,
                        child: const Text('Save changes'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

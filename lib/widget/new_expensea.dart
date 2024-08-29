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
  // var _enteredTitle = "";
  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // } the second approach to store the use input

  final _titlecontroller = TextEditingController();
  final TextEditingController _amountcontroller = TextEditingController();
  Catigory _selectedItem = Catigory.leisure;

  DateTime? _selectedDate;
  void _percentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 10, now.month, now.day);
    final pikedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);
    setState(() {
      _selectedDate = pikedDate;
    });
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  void _submitExpenseDate() {
    final enteredAmount = double.tryParse(_amountcontroller.text);
    final amountIsValid = enteredAmount == null || enteredAmount <= 0;
    if (_amountcontroller.text.trim().isEmpty ||
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
                      child: const Text("okey"))
                ],
              ));
      return;
    }
    widget.onAddItem(Expense(
        title: _titlecontroller.text,
        amount: enteredAmount,
        date: _selectedDate!,
        catigory: _selectedItem));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            //onChanged: _saveTitleInput,
            controller: _titlecontroller,
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Titles')),
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16)),
          Row(
            children: [
              Expanded(
                child: TextField(
                  //onChanged: _saveTitleInput,
                  controller: _amountcontroller,
                  keyboardType: TextInputType.number,

                  decoration: const InputDecoration(
                      prefixText: "\$ ", label: Text('Amount')),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? "not date Selected"
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                        onPressed: _percentDatePicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                  value: _selectedItem,
                  items: Catigory.values
                      .map((catogory) => DropdownMenuItem(
                          value: catogory,
                          child: Text(
                            catogory.name.toUpperCase(),
                          )))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedItem = value;
                    });
                  }),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                  onPressed: () => {Navigator.pop(context)},
                  child: const Text("Cancel")),
              ElevatedButton(
                  onPressed: _submitExpenseDate,
                  child: const Text("Save changes")),
            ],
          )
        ],
      ),
    );
  }
}

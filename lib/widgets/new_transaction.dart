import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime _selectedDate = DateTime(1999);

  void submitData() {
    final titleText = titleController.text;
    final amountText = double.parse(amountController.text);

    if (titleText == "" || amountText <= 0) return;
    print(titleController.text);
    print(amountController.text);
    widget.addTx(titleText, amountText);
    Navigator.pop(context);
  }

  void _pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null)
        return;
      else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              /*onChanged: (val) {
                      title = val;
                    },*/
              controller: titleController,
              onSubmitted: (_) {
                submitData();
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              //onChanged: (val) => amount = val,
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) {
                submitData();
              },
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == DateTime(1999)
                          ? 'No Date Choosen'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: _pickDate,
                  )
                ],
              ),
            ),
            ElevatedButton(
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}

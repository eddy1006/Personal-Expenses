import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_app/models/transaction.dart';
import 'package:personal_expense_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalAmount += recentTransactions[i].price;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalAmount};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + double.parse(item['amount'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 20,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'].toString(),
                  double.parse(data['amount'].toString()),
                  totalSpending == 0
                      ? 0.0
                      : (double.parse(data['amount'].toString()) /
                          totalSpending)),
            );
          }).toList(),
        ),
      ),
    );
  }
}

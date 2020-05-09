import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {

  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionsList(
    this.transactions,
    this.onRemove
  );

  @override
  Widget build(BuildContext context) {
    return  transactions.isEmpty 
        ? LayoutBuilder(
          builder: (ctx, constrains){
            return Column(
              children: <Widget>[
                SizedBox(height: constrains.maxHeight * 0.05),
                Container(
                  height: constrains.maxHeight * 0.3,
                  child: Text(
                    'Nenhuma Transação Cadastrada',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                SizedBox(height: constrains.maxHeight * 0.05),
                Container(
                  height: constrains.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          },
        )
        : ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (ctx, index){
            final tr = transactions[index];
            return Card(
              elevation: 6,
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text("R\$${tr.value}"),
                    ),
                  ),
                ),
                title: Text(
                  tr.title,
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  DateFormat("d MMM y").format(tr.date)
                ),
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor, 
                    onPressed: () => onRemove(tr.id)
                  ),
              )
            );
          },
        );
  }
}
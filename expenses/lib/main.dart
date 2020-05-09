import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';
import 'dart:math';


main()=> runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        button: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        )
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          )
        )
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _transactions = [
    Transaction(id: 't2', title: 'teste', value: 28.8, date: DateTime.now()),
     Transaction(id: 't21', title: 'teste', value: 28.8, date: DateTime.now()),
      Transaction(id: 't23', title: 'teste', value: 28.8, date: DateTime.now()),
       Transaction(id: 't24', title: 'teste', value: 28.8, date: DateTime.now()),
        Transaction(id: 't25', title: 'teste', value: 28.8, date: DateTime.now()),
         Transaction(id: 't26', title: 'teste', value: 28.8, date: DateTime.now()),
          Transaction(id: 't27', title: 'teste', value: 28.8, date: DateTime.now())
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr){
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7)
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date){
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title, 
      value: value, 
      date: date
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removetransaction(String id){
    setState(() {
      _transactions.removeWhere((tr)=> tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context){
    showModalBottomSheet(
      context: context, 
      builder: (_){
        return TransactionForm(_addTransaction);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape  = MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text("Despesas pessoais"),
      centerTitle: true,
      actions: <Widget>[
        if(isLandscape)
          IconButton(
            icon: Icon(_showChart ? Icons.insert_chart : Icons.list, color: Colors.amberAccent,), 
            onPressed: (){
              setState(() {
                _showChart = !_showChart;
              });
            }
          ),
        IconButton(
          icon: Icon(Icons.add), 
          onPressed: ()=> _openTransactionFormModal(context)
        )
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height
      - appBar.preferredSize.height -
      MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(_showChart || !isLandscape)
              Container(
                height: availableHeight * (isLandscape ? 0.7 : 0.3),
                child: Chart(_recentTransactions),
              ),
            if(!_showChart || !isLandscape) 
              Container(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: TransactionsList(_transactions, _removetransaction)
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=> _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
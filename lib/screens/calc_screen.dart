import 'package:challenge/models/calc_model.dart';
import 'package:challenge/screens/history_dialog.dart';
import 'package:challenge/theme/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  //1
  @override
  _MyAppState createState() => _MyAppState();
}

// class MyHomePage extends StatelessWidget {
class _MyAppState extends State {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  final TextEditingController valueAController = TextEditingController();
  final TextEditingController valueBController = TextEditingController();

  void _calculate(BuildContext context, double? _firstNumber, double? _secondNumber) {
    Provider.of<Calculator>(context, listen: false).calculate(_firstNumber, _secondNumber);
  }

  @override
  Widget build(BuildContext context) {
    var total = Provider.of<Calculator>(context).getTotal;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calc"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: valueAController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Value A',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: valueBController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Value B',
                ),
              ),
            ),
            const Text(
              'Your total is:',
            ),
            Text(
              total.toStringAsPrecision(3),
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(context: context, builder: (BuildContext context) => CustomDialog());
              },
              child: const Text('show history'),
            ),
            IconButton(
              icon: const Icon(Icons.brightness_4),
              onPressed: () => currentTheme.toggleTheme(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String _valueA = valueAController.text;
          double? valueA = double.tryParse(_valueA);
          String _valueB = valueBController.text;
          double? valueB = double.tryParse(_valueB);
          _calculate(context, valueA, valueB);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

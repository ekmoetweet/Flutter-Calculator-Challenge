import 'package:challenge/models/calc_model.dart';
import 'package:challenge/models/history_model.dart';
import 'package:challenge/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDialog extends StatelessWidget {
  List<HistoryItem>? _history = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HistoryItem>?>(
        future: getHistory(),
        builder: (BuildContext context, AsyncSnapshot<List<HistoryItem>?> snapshot) {
          if (snapshot.hasData) {
            _history = snapshot.data;
            _history = _history!.reversed.toList();
            _history != _history!.take(10);
          }
          return buildFrame(context);
        });
  }

  @override
  Widget buildFrame(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 0.0, right: 0.0),
        child: ListView.builder(
          reverse: false,
          shrinkWrap: true,
          itemCount: _history!.length,
          itemBuilder: (BuildContext context, int index) {
            final data = _history![index];
            return Provider.value(
              value: (_) => data,
              child: historyWidget(context, index),
            );
          },
        ));
  }

  @override
  Widget historyWidget(BuildContext context, int index) {
    return Card(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "Calculation: ${_history![index].calculation} ",
            style: TextStyle(color: CustomTheme.darkTheme.primaryColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Time Stamp: ${_history![index].time}",
            style: TextStyle(color: CustomTheme.darkTheme.primaryColor),
          ),
        ),
      ],
    ));
  }
}

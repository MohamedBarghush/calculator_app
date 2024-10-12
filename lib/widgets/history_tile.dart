import 'package:flutter/material.dart';

class HistoryTileWidget extends StatelessWidget {
  const HistoryTileWidget({super.key, required this.expression, required this.result});

  final String expression;
  final String result;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).disabledColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Text("$expression=$result",
                style: TextStyle(
                  fontSize: 42,
                  fontFamily: "Courier New",
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).hintColor,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

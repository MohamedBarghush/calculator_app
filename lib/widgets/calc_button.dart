import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  const CalcButton({
    super.key,
    this.intVal = 999,
    this.stringVal = "",
    required this.function,
    this.color = Colors.white, // Default color is blue
  });

  final String stringVal;
  final int intVal;
  final Function function;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Set button color
        shape: const RoundedRectangleBorder( // Set rectangular shape
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        elevation: 5.0, // Add shadow by setting elevation
        shadowColor: Colors.black.withOpacity(0.5), // Customize shadow color
      ),
      child: Center(
        child: AutoSizeText(
          intVal == 999 ? stringVal : intVal.toString(),
          maxFontSize: 30,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}

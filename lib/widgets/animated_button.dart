import 'package:calculator_app/widgets/history_data.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class AnimetedCustomButton extends StatefulWidget {
  const AnimetedCustomButton({
    super.key,
    required this.historyNotifier
  });

  final HistoryNotifier historyNotifier;

  @override
  State<AnimetedCustomButton> createState() => _AnimetedCustomButtonState();
}

class _AnimetedCustomButtonState extends State<AnimetedCustomButton> {
  double theScale = 1.3;
  Timer? timer;

  @override
  void dispose () {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {   
    return AnimatedScale(
      scale: theScale,
      duration: const Duration(milliseconds: 200),
      curve: Curves.bounceInOut,
      child: IconButton(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        onPressed: () {
          setState(() {
            theScale = 2;
          });
          timer = Timer(const Duration(milliseconds: 200), () {
            setState(() {
              theScale = 1.0;
            });
          });
          widget.historyNotifier.clearHistory();
        },
        icon: const Icon(Icons.delete_forever)
      ),
    );
  }
}
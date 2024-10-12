import 'package:calculator_app/widgets/animated_button.dart';
import 'package:calculator_app/widgets/history_data.dart';
import 'package:calculator_app/widgets/history_tile.dart';
import 'package:flutter/material.dart';
import 'package:calculator_app/data/constants.dart';

class HistoryPage extends StatefulWidget {

  final HistoryNotifier historyNotifier;

  const HistoryPage({super.key, required this.historyNotifier});

  @override
  State<HistoryPage> createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 30,
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: 80,
        title: const Text(
            "History",
            style: DEFAULT_TEXT_STYLE
          ),
        actions: [
          AnimetedCustomButton(historyNotifier: widget.historyNotifier),
        ],
      ),
      body: Stack(
        children: [
          ListenableBuilder(
            listenable: widget.historyNotifier,
            builder: (context, _) {
              return ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final HistoryTile historyTile = widget.historyNotifier.historyTiles[index];
                  return HistoryTileWidget (
                      expression: historyTile.expression,
                      result:historyTile.result,
                    );
                },
                itemCount: widget.historyNotifier.historyTiles.length,);
            }
          ),
        ]
      ),
    );
  }
}

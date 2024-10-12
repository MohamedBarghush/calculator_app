import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator_app/data/constants.dart';
import 'package:calculator_app/data/data.dart';
import 'package:calculator_app/pages/history_page.dart';
import 'package:calculator_app/widgets/calc_button.dart';
import 'package:calculator_app/widgets/history_data.dart';
import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HistoryNotifier historyNotifier = HistoryNotifier();
  bool isDark = true;
  String valToCalculate = ""; // Initialize this variable
  bool showingResult = false; // Added to manage result state

  void clear() {
    setState(() {
      valToCalculate = "";
      showingResult = false; // Reset result state
    });
  }

  void addNumber(int number) {
    if (showingResult) clear(); // Clear if showing result
    setState(() {
      valToCalculate += number.toString();
    });
  }

  void addOperator(String operator) {
    if (showingResult) clear(); // Clear if showing result
    setState(() {
      valToCalculate += operator;
    });
  }

  void calculate() {
    String expressionStr = valToCalculate.replaceAll("x", "*").replaceAll("÷", "/");
    showingResult = true; // Set result state to true

    try {
      // Parse and evaluate the expression
      Expression expression = Expression.parse(expressionStr);
      const evaluator = ExpressionEvaluator();
      var result = evaluator.eval(expression, {});

      historyNotifier.addHistoryTile(valToCalculate, result.toString());

      // Update display based on result type
      setState(() {
        valToCalculate = (result is double && result % 1 == 0) ? result.toInt().toString() : result.toString();
      });
    } catch (e) {
      // Handle evaluation error
      setState(() {
        valToCalculate = "Error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: CalculatorScaffold(
        isDark: isDark,
        valToCalculate: valToCalculate,
        historyNotifier: historyNotifier,
        onThemeToggle: () => setState(() => isDark = !isDark),
        onNumberPress: addNumber,
        onOperatorPress: addOperator,
        onClear: clear,
        onCalculate: calculate,
      ),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(color: Colors.blue),
      primaryColor: Colors.white,
      disabledColor: Colors.white38,
      secondaryHeaderColor: Colors.black,
      hintColor: Colors.black,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 42),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.black45,
      appBarTheme: const AppBarTheme(color: Color(0xFF2C2C2C)),
      primaryColor: Colors.black54,
      disabledColor: const Color(0xFF2C2C2C),
      secondaryHeaderColor: Colors.white,
      hintColor: Colors.white,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 42),
      ),
    );
  }
}

class CalculatorScaffold extends StatelessWidget {
  final bool isDark;
  final String valToCalculate;
  final HistoryNotifier historyNotifier;
  final VoidCallback onThemeToggle;
  final Function(int) onNumberPress;
  final Function(String) onOperatorPress;
  final VoidCallback onClear;
  final VoidCallback onCalculate;

  const CalculatorScaffold({
    super.key,
    required this.isDark,
    required this.valToCalculate,
    required this.historyNotifier,
    required this.onThemeToggle,
    required this.onNumberPress,
    required this.onOperatorPress,
    required this.onClear,
    required this.onCalculate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text("CALCULATOR", style: DEFAULT_TEXT_STYLE),
        actions: [
          IconButton(
            icon: isDark ? const Icon(Icons.dark_mode) : const Icon(Icons.dark_mode_outlined),
            iconSize: 40,
            color: Colors.white,
            onPressed: onThemeToggle,
          ),
          IconButton(
            icon: const Icon(Icons.history),
            iconSize: 40,
            color: Colors.white,
            onPressed: () => _navigateToHistoryPage(context),
          ),
        ],
      ),
      body: AspectRatio(
        aspectRatio: 1 / 1.25,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _buildDisplayArea(context),
              const SizedBox(height: 10),
              _buildButtonGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDisplayArea(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).disabledColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: AutoSizeText(
              valToCalculate,
              maxFontSize: 42,
              style: TextStyle(
                fontSize: 42, // Default fallback style
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black, // Fallback color
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 16, // 12 numbers/special buttons + 4 operators
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return CalcButton(
          intVal: buttons[index][0] is int ? buttons[index][0] : 999,
          stringVal: buttons[index][0] is int ? "" : buttons[index][0],
          color: isDark ? darkButtons[index][1] : buttons[index][1],
          function: () => _handleButtonPress(buttons[index][0]),
        );
      },
    );
  }

  void _handleButtonPress(dynamic buttonValue) {
    if (buttonValue is int) {
      onNumberPress(buttonValue);
    } else if (buttonValue == 'C') {
      onClear();
    } else if (buttonValue == '=') {
      onCalculate();
    } else {
      onOperatorPress(buttonValue);
    }
  }

  void _navigateToHistoryPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HistoryPage(historyNotifier: historyNotifier),
      ),
    );
  }
}

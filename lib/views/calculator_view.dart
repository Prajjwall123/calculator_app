import 'package:flutter/material.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  List<String> lstSymbols = [
    "C",
    "*",
    "/",
    "<-",
    "1",
    "2",
    "3",
    "+",
    "4",
    "5",
    "6",
    "-",
    "7",
    "8",
    "9",
    "*",
    "%",
    "0",
    ".",
    "=",
  ];

  String input = "";
  double? num1;
  double? num2;
  String? operation;

  void _onButtonPressed(String symbol) {
    setState(() {
      if (symbol == "C") {
        input = "";
        num1 = null;
        num2 = null;
        operation = null;
      } else if (symbol == "<-") {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else if (symbol == "=") {
        if (num1 != null && operation != null && input.isNotEmpty) {
          num2 = double.tryParse(input);
          if (num2 != null) {
            switch (operation) {
              case "+":
                input = (num1! + num2!).toString();
                break;
              case "-":
                input = (num1! - num2!).toString();
                break;
              case "*":
                input = (num1! * num2!).toString();
                break;
              case "/":
                if (num2 == 0) {
                  input = "Error";
                } else {
                  input = (num1! / num2!).toString();
                }
                break;

              case "%":
                input = (num1! % num2!).toString();
                break;

              default:
                break;
            }
          }
          num1 = null;
          operation = null;
        }
      } else if (["+", "-", "*", "/", "%"].contains(symbol)) {
          if (input.isNotEmpty) {
            num1 = double.tryParse(input);
            operation = symbol;
            input = "";
          }
        } else {
          input += symbol;
        }
        _textController.text = input;
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PrajwalPokhrel CalculatorApp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                textDirection: TextDirection.rtl,
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                readOnly: true,
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: lstSymbols.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => _onButtonPressed(lstSymbols[index]),
                      child: Text(
                        lstSymbols[index],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
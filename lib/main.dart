// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';

void main() {
  runApp(const Calculator());
}


class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _input = '';
  String _output = '';
  String _display = '';
  String _operation = '';
  double _num1 = 0;
  double _num2 = 0;
  bool _isResultDisplayed = false;

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        _input = '';
        _output = '';
        _operation = '';
        _num1 = 0;
        _num2 = 0;
        _display = '';
        _isResultDisplayed = false;
      }
      else if (_display.isNotEmpty && _isOperator(_display[_display.length - 1]) && _isOperator(buttonText)) {
        // Replace the last operator with the new one
        _display = _display.substring(0, _display.length - 1) + buttonText;
        _operation = buttonText;
      }
      else if (buttonText == '⌫') {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
          _display = _display.substring(0, _display.length - 1);
        }
      }
       else if (buttonText == '+' || buttonText == '-' || buttonText == '*' || buttonText == '/' || buttonText == '%') {
        _display = _display.substring(0, _display.length) + buttonText;
        _isResultDisplayed = false;
        _num1 = double.parse(_input);
        _operation = buttonText;
        _input = '';
      }
      else if (buttonText == '=') {
        _num2 = double.parse(_input);
          if (_operation == '+') {
            _output = (_num1 + _num2).toString();
          } 
          else if (_operation == '-') {
            _output = (_num1 - _num2).toString();
          } 
          else if (_operation == '*') {
            _output = (_num1 * _num2).toString();
          }
          else if (_operation == '/') {
            _output = (_num1 / _num2).toString();
          }
          else if (_operation == '%') {
            _output = (_num1 % _num2).toString();
          }
          _input = _output;
          _operation = '';
          _display = _output;
          _isResultDisplayed = true;
      }
      else {
        if (_isResultDisplayed) {
          _input = buttonText;
          _display = buttonText;
          _isResultDisplayed = false;
        } 
        else {
          _input += buttonText;
          _display+=buttonText;
        }
      }
    });
  }

  bool _isOperator(String value) {
    return value == '+' || value == '-' || value == '*' || value == '/' || value == '%';
  }

  Widget buttonBuild(String buttonText) {
    return Container(
        height: 60,
        width: 60,
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () => buttonPressed(buttonText), 
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            backgroundColor: Color.fromARGB(172, 207, 117, 0),
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            )
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              color: Color.fromARGB(207, 244, 244, 244),
              fontSize: 30
            ),
          ),
        )
      );    
  }

  Widget iconBuild(IconData icon) {
    return Container(
      height: 60,
      width: 60,
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () => buttonPressed('⌫'), 
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
            backgroundColor: Color.fromARGB(172, 207, 117, 0) ,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            )
          ),
        child: Icon(
        Icons.backspace,
        color: Color.fromARGB(207, 244, 244, 244)
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      title: 'Calculator',
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 36, 36, 35),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(24),
                height: 250,
                child: Text(
                  _display,
                  style: TextStyle(
                    fontSize: 50, 
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                    ),
                )
              ),
              // C,  '%' , '/' , Backspace -> Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  (buttonBuild('C')),
                  (buttonBuild('%')),
                  (buttonBuild('/')),
                  (iconBuild(Icons.backspace))
                ],
              ),
              // 1,2,3,'x' -> Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  (buttonBuild('1')),
                  (buttonBuild('2')),
                  (buttonBuild('3')),
                  (buttonBuild('x'))
                ],
              ),
              // 4,5,6,'-' -> Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  (buttonBuild('4')),
                  (buttonBuild('5')),
                  (buttonBuild('6')),
                  (buttonBuild('-'))
                ],
              ),
              // 7,8,9,'+' -> Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  (buttonBuild('7')),
                  (buttonBuild('8')),
                  (buttonBuild('9')),
                  (buttonBuild('+'))
                ],
              ),
              //'+/-' , '.' , 0, '=' -> Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  (buttonBuild('0')),
                  (buttonBuild('00')),
                  (buttonBuild('.')),
                  (buttonBuild('='))
                ],
              ),
            ],        
            ),
        ),
        ),
    );
  }
}
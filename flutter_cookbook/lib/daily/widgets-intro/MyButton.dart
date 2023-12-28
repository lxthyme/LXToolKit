import 'package:flutter/material.dart';

// void main() => runApp(MaterialApp(title: 'MyButton', home: MyButton()));

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyButton'),
      ),
      body: Center(child: GestureDetector(
        onTap: () {
          debugPrint('My Button tapped!');
        },
        child: Container(
          height: 50,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.lightGreen[500],
          ),
          child: const Center(
            child: Text(
              'Engage',
            ),
          ),
        ),
      )),
    );
  }
}

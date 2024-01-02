import 'package:flutter/material.dart';

class TodoText extends StatelessWidget {
  const TodoText({
    super.key,
    this.text = '',
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return const Text('todo...');
  }
}

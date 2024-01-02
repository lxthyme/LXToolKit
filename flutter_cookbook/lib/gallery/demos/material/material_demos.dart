import 'package:flutter/material.dart';
export 'package:flutter_cookbook/gallery/demos/material/app_bar_demo.dart';

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

import 'package:flutter/cupertino.dart';

export 'package:flutter_cookbook/gallery/demos/cupertino/cupertino_activity_indicator_demo.dart';
export 'package:flutter_cookbook/gallery/demos/cupertino/cupertino_alert_demo.dart';
export 'package:flutter_cookbook/gallery/demos/cupertino/cupertino_button_demo.dart';
export 'package:flutter_cookbook/gallery/demos/cupertino/cupertino_navigation_bar_demo.dart';
export 'package:flutter_cookbook/gallery/demos/cupertino/cupertino_scrollbar_demo.dart';
export 'package:flutter_cookbook/gallery/demos/cupertino/cupertino_segmented_control_demo.dart';
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

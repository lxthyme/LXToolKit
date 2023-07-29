import 'package:flutter/material.dart';

enum TwoPaneDemoType {
  foldable,
  table,
  smallScreen,
}

class TwoPaneDemo extends StatelessWidget {
  const TwoPaneDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Two pane demo'),
    );
  }
}

class ListPane extends StatelessWidget {
  const ListPane({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('List pane'),
    );
  }
}

class DetailsPane extends StatelessWidget {
  const DetailsPane({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('details pane'),
    );
  }
}

class SimulateScreen extends StatelessWidget {
  const SimulateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('simulate screen'),
    );
  }
}

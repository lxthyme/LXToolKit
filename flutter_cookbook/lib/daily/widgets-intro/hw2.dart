import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => {
              Navigator.of(context).pop(true)
            },
          ),
          automaticallyImplyLeading: true,
          title: const Text('Material App Bar'),
        ),
        body: Column(
          children: [
            MyScaffoldContent(
              title: Text('Example title', style: Theme.of(context).primaryTextTheme.titleLarge),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Hello world!',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(const MaterialApp(
//     title: 'My AppBar',
//     home: SafeArea(child: MyScaffold()),
//   ));
// }

class MyScaffoldContent extends StatelessWidget {
  const MyScaffoldContent({required this.title, super.key});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: Colors.blue[500]),
      child: Row(
        children: [
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
          ),
          Expanded(
            child: title,
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.search),
            tooltip: 'Search',
          )
        ],
      ),
    );
  }
}

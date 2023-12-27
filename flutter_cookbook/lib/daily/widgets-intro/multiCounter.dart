import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

// @pragma('vm:entry-point')
// void topMain() => runApp(const MultiCounter(color: Colors.blue));
// @pragma('vm:entry-point')
// void bottomMain() => runApp(const MultiCounter(color: Colors.green));

class MultiCounter extends StatelessWidget {
  const MultiCounter({super.key, required this.color});

  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Multi Counter",
      theme: ThemeData(
        colorSchemeSeed: color,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 8,
        ),
      ),
      home: const CounterHomePage(title: 'Flutter Counter'),
    );
  }
}

class CounterHomePage extends StatefulWidget {
  const CounterHomePage({super.key, required this.title});

  final String title;

  @override
  State<CounterHomePage> createState() => _CounterHomePageState();
}

class _CounterHomePageState extends State<CounterHomePage> {
  int? _counter = 0;
  late MethodChannel _channel;

  @override
  void initState() {
    super.initState();
    _channel = const MethodChannel("multiple-flutters");
    _channel.setMethodCallHandler((call) async => {
          if (call.method == "setCount")
            {
              setState(() {
                _counter = call.arguments as int?;
              })
            }
          else
            {throw Exception("not implemented ${call.method}")}
        });
  }

  void _incrementCounter() {
    _channel.invokeMethod<void>("incrementCount", _counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
              onPressed: _incrementCounter,
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                _channel.invokeMethod<void>('next', _counter);
              },
              child: const Text('Next'),
            ),
            ElevatedButton(
              onPressed: () async {
                final url = Uri.parse('https://flutter.dev/docs');
                if (await launcher.canLaunchUrl(url)) {
                  await launcher.launchUrl(url);
                }
              },
              child: const Text('Open Flutter Docs'),
            ),
          ],
        ),
      ),
    );
  }
}

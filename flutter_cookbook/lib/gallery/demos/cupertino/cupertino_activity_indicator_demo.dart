import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cookbook/tools/flutter_manager.dart';

// void main() => runApp(MaterialApp(title: 'Material App', home: CupertinoProgressIndicatorDemo()));

class CupertinoProgressIndicatorDemo extends StatelessWidget {
  const CupertinoProgressIndicatorDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // automaticallyImplyLeading: false,
        // leading: Icon(Icons.arrow_back_ios),
        // leading: CupertinoButton(
        //   child: const Icon(Icons.arrow_back_ios),
        //   // onPressed: (){},
        //   onPressed: () => {
        //     context.pop()
        //   },
        // ),
        // leading: IconButton(
        //   // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //   icon: Icon(Icons.arrow_back_ios),
        //   onPressed: () {},
        //   // onPressed: () => {
        //   //   context.pop();
        //   // },
        // ),
        middle: Text(
          '活动指示器',
        ),
      ),
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}

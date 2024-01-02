import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';

// void main() => runApp(MaterialApp(title: 'Material App', home: CupertinoProgressIndicatorDemo()));

class CupertinoProgressIndicatorDemo extends StatelessWidget {
  const CupertinoProgressIndicatorDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: Text(
          GalleryLocalizations.of(context)!.demoCupertinoActivityIndicatorTitle,
        ),
      ),
      child: const Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}

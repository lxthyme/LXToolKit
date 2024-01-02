import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';

class CupertinoButtonDemo extends StatelessWidget {
  const CupertinoButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = GalleryLocalizations.of(context)!;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: Text(localizations.demoCupertinoButtonsTitle),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
              onPressed: () {},
              child: Text(localizations.cupertinoButton),
            ),
            const SizedBox(height: 16),
            CupertinoButton.filled(
              onPressed: () {},
              child: Text(localizations.cupertinoButtonWithBackground),
            ),
            const SizedBox(height: 30),
            CupertinoButton(
              onPressed: null,
              child: Text(localizations.cupertinoButton),
            ),
            const SizedBox(height: 16),
            CupertinoButton.filled(
              onPressed: null,
              child: Text(localizations.cupertinoButtonWithBackground),
            )
          ],
        ),
      ),
    );
  }
}

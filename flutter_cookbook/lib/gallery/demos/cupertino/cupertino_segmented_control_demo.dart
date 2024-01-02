import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';

class CupertinoSegmentedControlDemo extends StatefulWidget {
  const CupertinoSegmentedControlDemo({super.key});

  @override
  State<CupertinoSegmentedControlDemo> createState() => _CupertinoSegmentedControlDemoState();
}

class _CupertinoSegmentedControlDemoState extends State<CupertinoSegmentedControlDemo> with RestorationMixin {
  RestorableInt currentSegment = RestorableInt(0);

  @override
  String? get restorationId => 'cupertino_segmented_control';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(currentSegment, 'current_segment');
  }

  void onValueChanged(int? newValue) {
    setState(() {
      currentSegment.value = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = GalleryLocalizations.of(context)!;
    const segmentedControlMaxWidth = 500.0;
    final children = <int, Widget>{
      0: Text(localizations.colorsIndigo),
      1: Text(localizations.colorsTeal),
      2: Text(localizations.colorsCyan),
    };

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: Text(
          localizations.demoCupertinoSegmentedControlTitle,
        ),
      ),
      child: DefaultTextStyle(
        style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontSize: 13),
        child: SafeArea(
          child: ListView(
            children: [
              const SizedBox(height: 16),
              SizedBox(
                width: segmentedControlMaxWidth,
                child: CupertinoSegmentedControl(
                  children: children,
                  onValueChanged: onValueChanged,
                  groupValue: currentSegment.value,
                ),
              ),
              SizedBox(
                width: segmentedControlMaxWidth,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CupertinoSlidingSegmentedControl(
                    children: children,
                    onValueChanged: onValueChanged,
                    groupValue: currentSegment.value,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                height: 300,
                alignment: Alignment.center,
                child: children[currentSegment.value],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

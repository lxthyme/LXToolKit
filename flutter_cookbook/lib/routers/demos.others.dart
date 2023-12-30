import 'package:flutter_cookbook/gallery/demos/reference/two_pane_demo.dart' deferred as twopane_demos;
import 'package:flutter_cookbook/gallery/codeviewer/code_segments.dart';
import 'package:flutter_cookbook/gallery/data/demos.dart';
import 'package:flutter_cookbook/gallery/data/icons.dart';
import 'package:flutter_cookbook/gallery/deferred_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension DemosOthersAll on DemosOthers {
  static List<GalleryRouterTest> otherList = [
    DemosOthers.twoPane,
  ];
}

class DemosOthers {
  static GalleryRouterTest twoPane = GalleryRouterTest(
    slug: '',
    widget: (AppLocalizations localizations) => GalleryDemo(
      title: localizations.demoTwoPaneTitle,
      icon: GalleryIcons.bottomSheetPersistent,
      slug: 'two-pane',
      subtitle: localizations.demoTwoPaneSubtitle,
      category: GalleryDemoCategory.other,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoTwoPaneFoldableLabel,
          description: localizations.demoTwoPaneFoldableDescription,
          documentationUrl: 'https://pub.dev/documentation/dual_screen/latest/dual_screen/TwoPane-class.html',
          buildRoute: (context) => DeferredWidget(
            twopane_demos.loadLibrary,
            () => twopane_demos.TwoPaneDemo(),
          ),
          code: CodeSegments.twoPaneDemo,
        ),
      ],
    ),
  );
}

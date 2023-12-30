import 'package:flutter_cookbook/gallery/constants.dart';
import 'package:flutter_cookbook/gallery/demos/cupertino/cupertino_demos.dart' deferred as cupertino_demos;
import 'package:flutter_cookbook/gallery/codeviewer/code_segments.dart';
import 'package:flutter_cookbook/gallery/data/demos.dart';
import 'package:flutter_cookbook/gallery/data/icons.dart';
import 'package:flutter_cookbook/gallery/deferred_widget.dart';
import 'package:flutter_cookbook/gallery/demos/cupertino/demo_types.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension DemosCupertinoAll on DemosCupertino {
  Future<void> pumpDeferredLibraries() {
    final futures = <Future<void>>[
      DeferredWidget.preload(cupertino_demos.loadLibrary),
    ];
    return Future.wait(futures);
  }

  static List<GalleryRouterTest> cupertinoList = [
    DemosCupertino.cupertinoActivityIndicator,
    DemosCupertino.cupertinoAlert,
  ];
}

class DemosCupertino {
  static LibraryLoader cupertinoLoader = cupertino_demos.loadLibrary;
  static GalleryRouterTest cupertinoActivityIndicator = GalleryRouterTest(
    slug: 'cupertino-activity-indicator',
    widget: (AppLocalizations localizations) => GalleryDemo(
      title: localizations.demoCupertinoActivityIndicatorTitle,
      icon: GalleryIcons.cupertinoProgress,
      slug: 'cupertino-activity-indicator',
      subtitle: localizations.demoCupertinoActivityIndicatorSubtitle,
      category: GalleryDemoCategory.cupertino,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoCupertinoActivityIndicatorTitle,
          description: localizations.demoCupertinoActivityIndicatorDescription,
          documentationUrl: '$kDocsBaseUrl/cupertino/CupertinoActivityIndicator-class.html',
          buildRoute: (context) => DeferredWidget(
            cupertinoLoader,
            () => cupertino_demos.CupertinoProgressIndicatorDemo(),
          ),
          code: CodeSegments.cupertinoActivityIndicatorDemo,
        ),
      ],
    ),
  );
  static GalleryRouterTest cupertinoAlert = GalleryRouterTest(
    slug: 'cupertino-alert',
    widget: (AppLocalizations localizations) => GalleryDemo(
      title: localizations.demoCupertinoAlertsTitle,
      icon: GalleryIcons.dialogs,
      slug: 'cupertino-alert',
      subtitle: localizations.demoCupertinoAlertsSubtitle,
      category: GalleryDemoCategory.cupertino,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoCupertinoAlertTitle,
          description: localizations.demoCupertinoAlertDescription,
          documentationUrl: '$kDocsBaseUrl/cupertino/CupertinoAlertDialog-class.html',
          buildRoute: (context) => DeferredWidget(
            cupertinoLoader,
            () => cupertino_demos.CupertinoAlertDemo(
              type: AlertDemoType.alert,
            ),
          ),
          code: CodeSegments.cupertinoAlertDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoCupertinoAlertWithTitleTitle,
          description: localizations.demoCupertinoAlertDescription,
          documentationUrl: '$kDocsBaseUrl/cupertino/CupertinoAlertDialog-class.html',
          buildRoute: (context) => DeferredWidget(
            cupertinoLoader,
            () => cupertino_demos.CupertinoAlertDemo(
              type: AlertDemoType.alertTitle,
            ),
          ),
          code: CodeSegments.cupertinoAlertDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoCupertinoAlertButtonsTitle,
          description: localizations.demoCupertinoAlertDescription,
          documentationUrl: '$kDocsBaseUrl/cupertino/CupertinoAlertDialog-class.html',
          buildRoute: (context) => DeferredWidget(
            cupertinoLoader,
            () => cupertino_demos.CupertinoAlertDemo(
              type: AlertDemoType.alertButtons,
            ),
          ),
          code: CodeSegments.cupertinoAlertDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoCupertinoAlertButtonsOnlyTitle,
          description: localizations.demoCupertinoAlertDescription,
          documentationUrl: '$kDocsBaseUrl/cupertino/CupertinoAlertDialog-class.html',
          buildRoute: (context) => DeferredWidget(
            cupertinoLoader,
            () => cupertino_demos.CupertinoAlertDemo(
              type: AlertDemoType.alertButtonsOnly,
            ),
          ),
          code: CodeSegments.cupertinoAlertDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoCupertinoActionSheetTitle,
          description: localizations.demoCupertinoActionSheetDescription,
          documentationUrl: '$kDocsBaseUrl/cupertino/CupertinoActionSheet-class.html',
          buildRoute: (context) => DeferredWidget(
            cupertinoLoader,
            () => cupertino_demos.CupertinoAlertDemo(
              type: AlertDemoType.actionSheet,
            ),
          ),
          code: CodeSegments.cupertinoAlertDemo,
        ),
      ],
    ),
  );
  // static GalleryDemo t(AppLocalizations localizations) =>
}

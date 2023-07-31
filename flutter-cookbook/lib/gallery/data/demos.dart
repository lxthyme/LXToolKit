import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cookbook/gallery/codeviewer/code_displayer.dart';
import 'package:flutter_cookbook/gallery/codeviewer/code_segments.dart';
import 'package:flutter_cookbook/gallery/data/icons.dart';
import 'package:flutter_cookbook/gallery/deferred_widget.dart';
import 'package:flutter_cookbook/gallery/demos/cupertino/demo_types.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_cookbook/gallery/demos/cupertino/cupertino_demos.dart' deferred as cupertino_demos;
import 'package:flutter_cookbook/gallery/demos/material/material_demos.dart' deferred as material_demos;
import 'package:flutter_cookbook/gallery/demos/reference/two_pane_demo.dart' deferred as twopane_demos;

const _docsBaseUrl = 'https://api.flutter.dev/flutter';
const _docsAnimationsUrl = 'https://pub.dev/documentation/animations/latest/animations';

enum GalleryDemoCategory {
  study,
  material,
  cupertino,
  other;

  @override
  String toString() {
    return name.toUpperCase();
  }

  String? displayTitle(AppLocalizations localizations) {
    switch (this) {
      case GalleryDemoCategory.other:
        return localizations.homeCategoryReference;
      case GalleryDemoCategory.material:
      case GalleryDemoCategory.cupertino:
        return toString();
      case GalleryDemoCategory.study:
    }
    return null;
  }
}

class GalleryDemo {
  const GalleryDemo({
    required this.title,
    required this.category,
    required this.subtitle,
    this.studyId,
    this.slug,
    this.icon,
    this.configurations = const [],
  })  : assert(category == GalleryDemoCategory.study || (slug != null && icon != null)),
        assert(slug != null || studyId != null);

  final String title;
  final GalleryDemoCategory category;
  final String subtitle;
  final String? studyId;
  final String? slug;
  final IconData? icon;
  final List<GalleryDemoConfiguration> configurations;

  String get describe => '${slug ?? studyId}@${category.name}';
}

class GalleryDemoConfiguration {
  const GalleryDemoConfiguration({
    required this.title,
    required this.description,
    required this.documentationUrl,
    required this.buildRoute,
    required this.code,
  });

  final String title;
  final String description;
  final String documentationUrl;
  final WidgetBuilder buildRoute;
  final CodeDisplayer code;
}

Future<void> pumpDeferredLibraries() {
  final futures = <Future<void>>[
    DeferredWidget.preload(cupertino_demos.loadLibrary),
  ];
  return Future.wait(futures);
}

class Demos {
  static Map<String?, GalleryDemo> asSlugToDemoMap(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return LinkedHashMap<String?, GalleryDemo>.fromIterable(
      all(localizations),
      key: (dynamic demo) => demo.slug as String?,
    );
  }

  static List<GalleryDemo> all(AppLocalizations localizations) =>
      studies(localizations).values.toList() +
      materialDemos(localizations) +
      cupertinoDemos(localizations) +
      otherDemos(localizations);

  static List<String> allDescriptions() => all(AppLocalizationsEn()).map((e) => e.describe).toList();

  static Map<String, GalleryDemo> studies(AppLocalizations localizations) {
    return <String, GalleryDemo>{
      'shrine': GalleryDemo(
        title: 'Shrine',
        subtitle: localizations.shrineDescription,
        category: GalleryDemoCategory.study,
        studyId: 'shrine',
      ),
    };
  }

  static List<GalleryDemo> materialDemos(AppLocalizations localizations) {
    LibraryLoader materialDemosLibrary = material_demos.loadLibrary;
    return [
      GalleryDemo(
        title: localizations.demoAppBarTitle,
        icon: GalleryIcons.appbar,
        slug: 'app-bar',
        subtitle: localizations.demoAppBarSubtitle,
        category: GalleryDemoCategory.material,
        configurations: [
          GalleryDemoConfiguration(
            title: localizations.demoAppBarTitle,
            description: localizations.demoAppBarDescription,
            documentationUrl: '$_docsBaseUrl/material/AppBar-class.html',
            buildRoute: (context) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.AppBarDemo(),
            ),
            code: CodeSegments.appbarDemo,
          ),
        ],
      ),
    ];
  }

  static cupertinoDemos(AppLocalizations localizations) {
    LibraryLoader cupertinoLoader = cupertino_demos.loadLibrary;
    return [
      GalleryDemo(
        title: localizations.demoCupertinoActivityIndicatorTitle,
        icon: GalleryIcons.cupertinoProgress,
        slug: 'cupertino-activity-indicator',
        subtitle: localizations.demoCupertinoActivityIndicatorSubtitle,
        category: GalleryDemoCategory.cupertino,
        configurations: [
          GalleryDemoConfiguration(
            title: localizations.demoCupertinoActivityIndicatorTitle,
            description: localizations.demoCupertinoActivityIndicatorDescription,
            documentationUrl: '$_docsBaseUrl/cupertino/CupertinoActivityIndicator-class.html',
            buildRoute: (context) => DeferredWidget(
              cupertinoLoader,
              () => cupertino_demos.CupertinoProgressIndicatorDemo(),
            ),
            code: CodeSegments.cupertinoActivityIndicatorDemo,
          ),
        ],
      ),
      GalleryDemo(
        title: localizations.demoCupertinoAlertsTitle,
        icon: GalleryIcons.dialogs,
        slug: 'cupertino-alert',
        subtitle: localizations.demoCupertinoAlertsSubtitle,
        category: GalleryDemoCategory.cupertino,
        configurations: [
          GalleryDemoConfiguration(
            title: localizations.demoCupertinoAlertTitle,
            description: localizations.demoCupertinoAlertDescription,
            documentationUrl: '$_docsBaseUrl/cupertino/CupertinoAlertDialog-class.html',
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
            documentationUrl: '$_docsBaseUrl/cupertino/CupertinoAlertDialog-class.html',
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
            documentationUrl: '$_docsBaseUrl/cupertino/CupertinoAlertDialog-class.html',
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
            documentationUrl: '$_docsBaseUrl/cupertino/CupertinoAlertDialog-class.html',
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
            documentationUrl: '$_docsBaseUrl/cupertino/CupertinoActionSheet-class.html',
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
    ];
  }

  static List<GalleryDemo> otherDemos(AppLocalizations localizations) {
    return [
      GalleryDemo(
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
          ]),
    ];
  }
}

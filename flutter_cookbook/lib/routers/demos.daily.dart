import 'package:flutter/material.dart';
import 'package:flutter_cookbook/daily/daily_demos.dart' deferred as daily_demos;
import 'package:flutter_cookbook/gallery/codeviewer/code_segments.dart';
import 'package:flutter_cookbook/gallery/data/demos.dart';
import 'package:flutter_cookbook/gallery/data/icons.dart';
import 'package:flutter_cookbook/gallery/deferred_widget.dart';
import 'package:flutter_cookbook/gallery/pages/demo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension DemosDailyAll on DemosDaily {
  static List<GalleryDemo> dailyList(AppLocalizations localizations) {
    return [
      DemosDaily.myScaffold(localizations),
      DemosDaily.tutorialHome(localizations),
      DemosDaily.myButton(localizations),
      DemosDaily.counter(localizations),
      DemosDaily.multiCounter(localizations),
    ];
  }
}

class DemosDaily {
  static LibraryLoader dailyDemosLibrary = daily_demos.loadLibrary;
  static GalleryDemo myScaffold(AppLocalizations localizations) => GalleryDemo(
        title: 'MyScaffold',
        icon: GalleryIcons.appbar,
        baseRoute: DemoPage.daily,
        slug: 'MyScaffold',
        subtitle: 'hw2',
        category: GalleryDemoCategory.daily,
        configurations: [
          GalleryDemoConfiguration(
            title: localizations.demoAppBarTitle,
            description: localizations.demoAppBarDescription,
            documentationUrl: 'https://zhihu.com',
            buildRoute: (context) => DeferredWidget(
              dailyDemosLibrary,
              () => daily_demos.MyScaffold(),
            ),
            code: CodeSegments.appbarDemo,
          ),
        ],
      );
  static GalleryDemo tutorialHome(AppLocalizations localizations) => GalleryDemo(
        title: 'TutorialHome',
        icon: GalleryIcons.appbar,
        baseRoute: DemoPage.daily,
        slug: 'TutorialHome',
        subtitle: 'hw3',
        category: GalleryDemoCategory.daily,
        configurations: [
          GalleryDemoConfiguration(
            title: localizations.demoAppBarTitle,
            description: localizations.demoAppBarDescription,
            documentationUrl: 'https://zhihu.com',
            buildRoute: (context) => DeferredWidget(
              dailyDemosLibrary,
              () => daily_demos.TutorialHome(),
            ),
            code: CodeSegments.appbarDemo,
          ),
        ],
      );
  static GalleryDemo myButton(AppLocalizations localizations) => GalleryDemo(
        title: 'MyButton',
        icon: GalleryIcons.appbar,
        baseRoute: DemoPage.daily,
        slug: 'MyButton',
        subtitle: 'mybutton',
        category: GalleryDemoCategory.daily,
        configurations: [
          GalleryDemoConfiguration(
            title: localizations.demoAppBarTitle,
            description: localizations.demoAppBarDescription,
            documentationUrl: 'https://zhihu.com',
            buildRoute: (context) => DeferredWidget(
              dailyDemosLibrary,
              () => daily_demos.MyButton(),
            ),
            code: CodeSegments.appbarDemo,
          ),
        ],
      );
  static GalleryDemo counter(AppLocalizations localizations) => GalleryDemo(
        title: 'Counter',
        icon: GalleryIcons.appbar,
        baseRoute: DemoPage.daily,
        slug: 'Counter',
        subtitle: 'counter',
        category: GalleryDemoCategory.daily,
        configurations: [
          GalleryDemoConfiguration(
            title: localizations.demoAppBarTitle,
            description: localizations.demoAppBarDescription,
            documentationUrl: 'https://zhihu.com',
            buildRoute: (context) => DeferredWidget(
              dailyDemosLibrary,
              () => daily_demos.Counter(),
            ),
            code: CodeSegments.appbarDemo,
          ),
        ],
      );
  static GalleryDemo multiCounter(AppLocalizations localizations) => GalleryDemo(
        title: 'Multi Counter',
        icon: GalleryIcons.appbar,
        baseRoute: DemoPage.daily,
        slug: 'MultiCounter',
        subtitle: 'multi counter',
        category: GalleryDemoCategory.daily,
        configurations: [
          GalleryDemoConfiguration(
            title: localizations.demoAppBarTitle,
            description: localizations.demoAppBarDescription,
            documentationUrl: 'https://zhihu.com',
            buildRoute: (context) => DeferredWidget(
              dailyDemosLibrary,
              () => daily_demos.MultiCounter(color: Colors.orange),
            ),
            code: CodeSegments.appbarDemo,
          ),
        ],
      );
  // static GalleryDemo (AppLocalizations localizations) =>
  // static GalleryDemo (AppLocalizations localizations) =>
}

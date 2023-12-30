import 'package:flutter/material.dart';
import 'package:flutter_cookbook/daily/daily_demos.dart' deferred as daily_demos;
import 'package:flutter_cookbook/gallery/codeviewer/code_segments.dart';
import 'package:flutter_cookbook/gallery/data/demos.dart';
import 'package:flutter_cookbook/gallery/data/icons.dart';
import 'package:flutter_cookbook/gallery/deferred_widget.dart';
import 'package:flutter_cookbook/gallery/pages/demo.dart';

extension DemosDailyAll on DemosDaily {
  static List<GalleryRouterTest> dailyList = [
    DemosDaily.myScaffold,
    DemosDaily.tutorialHome,
    DemosDaily.myButton,
    DemosDaily.counter,
    DemosDaily.multiCounter,
  ];
}

class DemosDaily {
  static LibraryLoader dailyDemosLibrary = daily_demos.loadLibrary;
  static GalleryRouterTest myScaffold = GalleryRouterTest(
    baseRoute: DemoPage.daily,
    slug: 'MyScaffold',
    widget: (localizations) => GalleryDemo(
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
    ),
  );

  static GalleryRouterTest tutorialHome = GalleryRouterTest(
    baseRoute: DemoPage.daily,
    slug: 'TutorialHome',
    widget: (localizations) => GalleryDemo(
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
    ),
  );
  static GalleryRouterTest myButton = GalleryRouterTest(
    baseRoute: DemoPage.daily,
    slug: 'MyButton',
    widget: (localizations) => GalleryDemo(
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
    ),
  );
  static GalleryRouterTest counter = GalleryRouterTest(
    baseRoute: DemoPage.daily,
    slug: 'Counter',
    widget: (localizations) => GalleryDemo(
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
    ),
  );
  static GalleryRouterTest multiCounter = GalleryRouterTest(
    baseRoute: DemoPage.daily,
    slug: 'MultiCounter',
    widget: (localizations) => GalleryDemo(
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
    ),
  );
  // static GalleryDemo (GalleryLocalizations localizations) =>
  // static GalleryDemo (GalleryLocalizations localizations) =>
}

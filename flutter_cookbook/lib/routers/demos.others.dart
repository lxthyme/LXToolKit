import 'package:flutter_cookbook/gallery/codeviewer/code_segments.dart';
import 'package:flutter_cookbook/gallery/constants.dart';
import 'package:flutter_cookbook/gallery/data/demos.dart';
import 'package:flutter_cookbook/gallery/data/icons.dart';
import 'package:flutter_cookbook/gallery/deferred_widget.dart';
import 'package:flutter_cookbook/gallery/demos/reference/colors_demo.dart'
    deferred as colors_demo;
import 'package:flutter_cookbook/gallery/demos/reference/motion_demo_container_transition.dart'
    deferred as motion_demo_container;
import 'package:flutter_cookbook/gallery/demos/reference/transformations_demo.dart'
    deferred as transformations_demo;
import 'package:flutter_cookbook/gallery/demos/reference/two_pane_demo.dart' deferred as twopane_demo;
import 'package:flutter_cookbook/gallery/demos/reference/typography_demo.dart'
    deferred as typography;

extension DemosOthersAll on DemosOthers {
  static List<GalleryRouterTest> otherList = [
    DemosOthers.demoTwoPane,
    DemosOthers.demoMotion,
    DemosOthers.demoColors,
    DemosOthers.demoTypography,
    DemosOthers.demoTransformations,
  ];
}

class DemosOthers {
  static GalleryRouterTest demoTwoPane = GalleryRouterTest(
    slug: 'two-pane',
    widget: (localizations) => GalleryDemo(
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
            twopane_demo.loadLibrary,
            () => twopane_demo.TwoPaneDemo(),
          ),
          code: CodeSegments.twoPaneDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoTwoPaneTabletLabel,
          description: localizations.demoTwoPaneTabletDescription,
          documentationUrl: 'https://pub.dev/documentation/dual_screen/latest/dual_screen/TwoPane-class.html',
          buildRoute: (_) => DeferredWidget(
            twopane_demo.loadLibrary,
            () => twopane_demo.TwoPaneDemo(
              // type: twopane_demo.TwoPaneDemoType.tablet,
              // restorationId: 'two_pane_tablet',
            ),
          ),
          code: CodeSegments.twoPaneDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoTwoPaneSmallScreenLabel,
          description: localizations.demoTwoPaneSmallScreenDescription,
          documentationUrl: 'https://pub.dev/documentation/dual_screen/latest/dual_screen/TwoPane-class.html',
          buildRoute: (_) => DeferredWidget(
            twopane_demo.loadLibrary,
            () => twopane_demo.TwoPaneDemo(
              // type: twopane_demo.TwoPaneDemoType.smallScreen,
              // restorationId: 'two_pane_single',
            ),
          ),
          code: CodeSegments.twoPaneDemo,
        ),
      ],
    ),
  );
  static GalleryRouterTest demoMotion = GalleryRouterTest(
    slug: 'motion',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoMotionTitle,
      icon: GalleryIcons.animation,
      slug: 'motion',
      subtitle: localizations.demoMotionSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoContainerTransformTitle,
          description: localizations.demoContainerTransformDescription,
          documentationUrl: '$kDocsBaseUrl/OpenContainer-class.html',
          buildRoute: (_) => DeferredWidget(
            motion_demo_container.loadLibrary,
            () => motion_demo_container.TodoText(),
          ),
          code: CodeSegments.openContainerTransformDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoSharedXAxisTitle,
          description: localizations.demoSharedAxisDescription,
          documentationUrl: '$kDocsBaseUrl/SharedAxisTransition-class.html',
          buildRoute: (_) => motion_demo_container.TodoText(text: 'const SharedXAxisTransitionDemo()'),
          code: CodeSegments.sharedXAxisTransitionDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoSharedYAxisTitle,
          description: localizations.demoSharedAxisDescription,
          documentationUrl: '$kDocsBaseUrl/SharedAxisTransition-class.html',
          buildRoute: (_) => motion_demo_container.TodoText(text: 'const SharedYAxisTransitionDemo()'),
          code: CodeSegments.sharedYAxisTransitionDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoSharedZAxisTitle,
          description: localizations.demoSharedAxisDescription,
          documentationUrl: '$kDocsBaseUrl/SharedAxisTransition-class.html',
          buildRoute: (_) => motion_demo_container.TodoText(text: 'const SharedZAxisTransitionDemo()'),
          code: CodeSegments.sharedZAxisTransitionDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoFadeThroughTitle,
          description: localizations.demoFadeThroughDescription,
          documentationUrl: '$kDocsBaseUrl/FadeThroughTransition-class.html',
          buildRoute: (_) => motion_demo_container.TodoText(text: 'const FadeThroughTransitionDemo()'),
          code: CodeSegments.fadeThroughTransitionDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoFadeScaleTitle,
          description: localizations.demoFadeScaleDescription,
          documentationUrl: '$kDocsBaseUrl/FadeScaleTransition-class.html',
          buildRoute: (_) => motion_demo_container.TodoText(text: 'const FadeScaleTransitionDemo()'),
          code: CodeSegments.fadeScaleTransitionDemo,
        ),
      ],
      category: GalleryDemoCategory.other,
    ),
  );
  static GalleryRouterTest demoColors = GalleryRouterTest(
    slug: 'colors',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoColorsTitle,
      icon: GalleryIcons.colors,
      slug: 'colors',
      subtitle: localizations.demoColorsSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoColorsTitle,
          description: localizations.demoColorsDescription,
          documentationUrl: '$kDocsBaseUrl/material/MaterialColor-class.html',
          buildRoute: (_) => DeferredWidget(
            colors_demo.loadLibrary,
            () => colors_demo.TodoText(),
          ),
          code: CodeSegments.colorsDemo,
        ),
      ],
      category: GalleryDemoCategory.other,
    ),
  );
  static GalleryRouterTest demoTypography = GalleryRouterTest(
    slug: 'typography',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoTypographyTitle,
      icon: GalleryIcons.customTypography,
      slug: 'typography',
      subtitle: localizations.demoTypographySubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoTypographyTitle,
          description: localizations.demoTypographyDescription,
          documentationUrl: '$kDocsBaseUrl/material/TextTheme-class.html',
          buildRoute: (_) => DeferredWidget(
            typography.loadLibrary,
            () => typography.TodoText(),
          ),
          code: CodeSegments.typographyDemo,
        ),
      ],
      category: GalleryDemoCategory.other,
    ),
  );
  static GalleryRouterTest demoTransformations = GalleryRouterTest(
    slug: '2d-transformations',
    widget: (localizations) => GalleryDemo(
      title: localizations.demo2dTransformationsTitle,
      icon: GalleryIcons.gridOn,
      slug: '2d-transformations',
      subtitle: localizations.demo2dTransformationsSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demo2dTransformationsTitle,
          description: localizations.demo2dTransformationsDescription,
          documentationUrl: '$kDocsBaseUrl/widgets/GestureDetector-class.html',
          buildRoute: (_) => DeferredWidget(
            transformations_demo.loadLibrary,
            () => transformations_demo.TodoText(),
          ),
          code: CodeSegments.transformationsDemo,
        ),
      ],
      category: GalleryDemoCategory.other,
    ),
  );
}

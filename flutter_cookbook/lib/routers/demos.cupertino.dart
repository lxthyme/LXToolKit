import 'package:flutter/material.dart';
import 'package:flutter_cookbook/gallery/codeviewer/code_segments.dart';
import 'package:flutter_cookbook/gallery/constants.dart';
import 'package:flutter_cookbook/gallery/data/demos.dart';
import 'package:flutter_cookbook/gallery/data/icons.dart';
import 'package:flutter_cookbook/gallery/deferred_widget.dart';
import 'package:flutter_cookbook/gallery/demos/cupertino/cupertino_demos.dart' deferred as cupertino_demos;
import 'package:flutter_cookbook/gallery/demos/material/material_demos.dart'
    deferred as material_demos;
import 'package:flutter_cookbook/gallery/demos/reference/colors_demo.dart'
    deferred as colors_demo;
import 'package:flutter_cookbook/gallery/demos/reference/motion_demo_container_transition.dart'
    deferred as motion_demo_container;
import 'package:flutter_cookbook/gallery/demos/reference/transformations_demo.dart'
    deferred as transformations_demo;
import 'package:flutter_cookbook/gallery/demos/reference/two_pane_demo.dart'
    deferred as twopane_demo;
import 'package:flutter_cookbook/gallery/demos/reference/typography_demo.dart'
    deferred as typography;
import 'package:flutter_cookbook/gallery/demos/cupertino/demo_types.dart';

extension DemosCupertinoAll on DemosCupertino {
  Future<void> pumpDeferredLibraries() {
    final futures = <Future<void>>[
      DeferredWidget.preload(cupertino_demos.loadLibrary),
      DeferredWidget.preload(material_demos.loadLibrary),
      DeferredWidget.preload(motion_demo_container.loadLibrary),
      DeferredWidget.preload(colors_demo.loadLibrary),
      DeferredWidget.preload(transformations_demo.loadLibrary),
      DeferredWidget.preload(typography.loadLibrary),
    ];
    return Future.wait(futures);
  }

  static List<GalleryRouterTest> cupertinoList = [
    DemosCupertino.cupertinoActivityIndicator,
    DemosCupertino.cupertinoAlert,
    DemosCupertino.cupertinoButton,
    DemosCupertino.cupertinoContextMenu,
    DemosCupertino.cupertinoNavigationBar,
    DemosCupertino.cupertinoPicker,
    DemosCupertino.cupertinoScrollbar,
    DemosCupertino.cupertinoSegmentedControl,
    DemosCupertino.cupertinoSlider,
    DemosCupertino.cupertinoSwitch,
    DemosCupertino.cupertinoTabbar,
    DemosCupertino.cupertinoTextField,
    DemosCupertino.cupertinoSearchTextField,
    // DemosCupertino.cupertino,
  ];
}

class DemosCupertino {
  static LibraryLoader cupertinoLoader = cupertino_demos.loadLibrary;
  static GalleryRouterTest cupertinoActivityIndicator = GalleryRouterTest(
    slug: 'cupertino-activity-indicator',
    widget: (localizations) => GalleryDemo(
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
    widget: (localizations) => GalleryDemo(
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

  static GalleryRouterTest cupertinoButton = GalleryRouterTest(
    slug: 'cupertino-buttons',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoCupertinoButtonsTitle,
      icon: GalleryIcons.genericButtons,
      slug: 'cupertino-buttons',
      subtitle: localizations.demoCupertinoButtonsSubtitle,
      category: GalleryDemoCategory.cupertino,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoCupertinoButtonsTitle,
          description: localizations.demoCupertinoButtonsDescription,
          documentationUrl: '$kDocsBaseUrl/cupertino/CupertinoButton-class.html',
          buildRoute: (_) => DeferredWidget(
            cupertinoLoader,
            () => cupertino_demos.CupertinoButtonDemo(),
          ),
          code: CodeSegments.cupertinoButtonDemo,
        )
      ],
    ),
  );
  static GalleryRouterTest cupertinoContextMenu = GalleryRouterTest(
    slug: 'cupertino-context-menu',
    widget: (localizations) => GalleryDemo(
      slug: 'cupertino-context-menu',
      icon: GalleryIcons.moreVert,
      title: localizations.demoContextMenuTitle,
      subtitle: localizations.demoCupertinoContextMenuSubtitle,
      category: GalleryDemoCategory.cupertino,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoContextMenuTitle,
          description: localizations.demoCupertinoContextMenuDescription,
          documentationUrl: '$kDocsBaseUrl/cupertino/CupertinoContextMenu-class.html',
          buildRoute: (_) => DeferredWidget(
            cupertinoLoader,
            () => const Text('todo...'),
          ),
          code: CodeSegments.cupertinoContextMenuDemo,
        )
      ],
    ),
  );
  static GalleryRouterTest cupertinoNavigationBar = GalleryRouterTest(
    slug: 'cupertino-navigation-bar',
    widget: (localizations) => GalleryDemo(
      slug: 'cupertino-navigation-bar',
      icon: GalleryIcons.bottomSheetPersistent,
      title: localizations.demoCupertinoNavigationBarTitle,
      subtitle: localizations.demoCupertinoNavigationBarSubtitle,
      category: GalleryDemoCategory.cupertino,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoCupertinoNavigationBarTitle,
          description: localizations.demoCupertinoNavigationBarDescription,
          documentationUrl: '$kDocsBaseUrl/cupertino/CupertinoNavigationBar-class.html',
          buildRoute: (_) => DeferredWidget(
            cupertinoLoader,
            () => cupertino_demos.CupertinoNavigationBarDemo(),
          ),
          code: CodeSegments.cupertinoNavigationBarDemo,
        )
      ],
    ),
  );
  static GalleryRouterTest cupertinoPicker = GalleryRouterTest(
    slug: 'cupertino-picker',
    widget: (localizations) => GalleryDemo(
      slug: 'cupertino-picker',
      icon: GalleryIcons.listAlt,
      title: localizations.demoCupertinoPickerTitle,
      subtitle: localizations.demoCupertinoPickerSubtitle,
      category: GalleryDemoCategory.cupertino,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoCupertinoPickerTitle,
          description: localizations.demoCupertinoPickerDescription,
          documentationUrl: '$kDocsBaseUrl/cupertino/CupertinoDatePicker-class.html',
          buildRoute: (_) => DeferredWidget(
            cupertinoLoader,
            () => const Text('todo...'),
          ),
          code: CodeSegments.cupertinoPickersDemo,
        )
      ],
    ),
  );
  static GalleryRouterTest cupertinoScrollbar = GalleryRouterTest(
    slug: 'cupertino-scrollbar',
    widget: (localizations) => GalleryDemo(
      slug: 'cupertino-scrollbar',
      icon: GalleryIcons.listAlt,
      title: localizations.demoCupertinoScrollbarTitle,
      subtitle: localizations.demoCupertinoScrollbarSubtitle,
      category: GalleryDemoCategory.cupertino,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoCupertinoScrollbarTitle,
          description: localizations.demoCupertinoScrollbarDescription,
          documentationUrl: '$kDocsBaseUrl/cupertino/CupertinoScrollbar-class.html',
          buildRoute: (_) => DeferredWidget(
            cupertinoLoader,
            () => cupertino_demos.CupertinoScrollbarDemo(),
          ),
          code: CodeSegments.cupertinoScrollbarDemo,
        )
      ],
    ),
  );
  static GalleryRouterTest cupertinoSegmentedControl = GalleryRouterTest(
    slug: 'cupertino-segmented-control',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoCupertinoSegmentedControlTitle,
      icon: GalleryIcons.tabs,
      slug: 'cupertino-segmented-control',
      subtitle: localizations.demoCupertinoSegmentedControlSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoCupertinoSegmentedControlTitle,
          description: localizations.demoCupertinoSegmentedControlDescription,
          documentationUrl: '$kDocsBaseUrl/cupertino/CupertinoSegmentedControl-class.html',
          buildRoute: (_) => DeferredWidget(
            cupertinoLoader,
            () => cupertino_demos.CupertinoSegmentedControlDemo(),
          ),
          code: CodeSegments.cupertinoSegmentedControlDemo,
        ),
      ],
      category: GalleryDemoCategory.cupertino,
    ),
  );
  static GalleryRouterTest cupertinoSlider = GalleryRouterTest(
    slug: 'cupertino-slider',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoCupertinoSliderTitle,
      icon: GalleryIcons.sliders,
      slug: 'cupertino-slider',
      subtitle: localizations.demoCupertinoSliderSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoCupertinoSliderTitle,
          description: localizations.demoCupertinoSliderDescription,
          documentationUrl: '$kDocsBaseUrl/cupertino/CupertinoSlider-class.html',
          buildRoute: (_) => DeferredWidget(
            cupertinoLoader,
            () => cupertino_demos.TodoText(),
          ),
          code: CodeSegments.cupertinoSliderDemo,
        ),
      ],
      category: GalleryDemoCategory.cupertino,
    ),
  );
  static GalleryRouterTest cupertinoSwitch = GalleryRouterTest(
    slug: 'cupertino-switch',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoSelectionControlsSwitchTitle,
      icon: GalleryIcons.cupertinoSwitch,
      slug: 'cupertino-switch',
      subtitle: localizations.demoCupertinoSwitchSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoSelectionControlsSwitchTitle,
          description: localizations.demoCupertinoSwitchDescription,
          documentationUrl: '$kDocsBaseUrl/cupertino/CupertinoSwitch-class.html',
          buildRoute: (_) => DeferredWidget(
            cupertinoLoader,
            () => cupertino_demos.TodoText(),
          ),
          code: CodeSegments.cupertinoSwitchDemo,
        ),
      ],
      category: GalleryDemoCategory.cupertino,
    ),
  );
  static GalleryRouterTest cupertinoTabbar = GalleryRouterTest(
    slug: 'cupertino-tab-bar',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoCupertinoTabBarTitle,
      icon: GalleryIcons.bottomNavigation,
      slug: 'cupertino-tab-bar',
      subtitle: localizations.demoCupertinoTabBarSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoCupertinoTabBarTitle,
          description: localizations.demoCupertinoTabBarDescription,
          documentationUrl: '$kDocsBaseUrl/cupertino/CupertinoTabBar-class.html',
          buildRoute: (_) => DeferredWidget(
            cupertinoLoader,
            () => cupertino_demos.TodoText(),
          ),
          code: CodeSegments.cupertinoNavigationDemo,
        ),
      ],
      category: GalleryDemoCategory.cupertino,
    ),
  );
  static GalleryRouterTest cupertinoTextField = GalleryRouterTest(
    slug: 'cupertino-text-field',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoCupertinoTextFieldTitle,
      icon: GalleryIcons.textFieldsAlt,
      slug: 'cupertino-text-field',
      subtitle: localizations.demoCupertinoTextFieldSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoCupertinoTextFieldTitle,
          description: localizations.demoCupertinoTextFieldDescription,
          documentationUrl: '$kDocsBaseUrl/cupertino/CupertinoTextField-class.html',
          buildRoute: (_) => DeferredWidget(
            cupertinoLoader,
            () => cupertino_demos.TodoText(),
          ),
          code: CodeSegments.cupertinoTextFieldDemo,
        ),
      ],
      category: GalleryDemoCategory.cupertino,
    ),
  );
  static GalleryRouterTest cupertinoSearchTextField = GalleryRouterTest(
    slug: 'cupertino-search-text-field',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoCupertinoSearchTextFieldTitle,
      icon: GalleryIcons.search,
      slug: 'cupertino-search-text-field',
      subtitle: localizations.demoCupertinoSearchTextFieldSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoCupertinoSearchTextFieldTitle,
          description: localizations.demoCupertinoSearchTextFieldDescription,
          documentationUrl: '$kDocsBaseUrl/cupertino/CupertinoSearchTextField-class.html',
          buildRoute: (_) => DeferredWidget(
            cupertinoLoader,
            () => cupertino_demos.TodoText(),
          ),
          code: CodeSegments.cupertinoTextFieldDemo,
        ),
      ],
      category: GalleryDemoCategory.cupertino,
    ),
  );
  // static GalleryDemo t(GalleryLocalizations localizations) =>
}

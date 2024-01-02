import 'package:flutter_cookbook/gallery/codeviewer/code_segments.dart';
import 'package:flutter_cookbook/gallery/constants.dart';
import 'package:flutter_cookbook/gallery/data/demos.dart';
import 'package:flutter_cookbook/gallery/data/icons.dart';
import 'package:flutter_cookbook/gallery/deferred_widget.dart';
import 'package:flutter_cookbook/gallery/demos/material/material_demos.dart' deferred as material_demos;

extension DemosMaterialAll on DemosMaterial {
  static List<GalleryRouterTest> materialList = [
    DemosMaterial.appBar,
    DemosMaterial.banner,
    DemosMaterial.bottomAppBar,
    DemosMaterial.bottomNavigation,
    DemosMaterial.bottomSheet,
    DemosMaterial.button,
    DemosMaterial.card,
    DemosMaterial.chip,
    DemosMaterial.dataTable,
    DemosMaterial.dialog,
    DemosMaterial.divider,
    DemosMaterial.gridLists,
    DemosMaterial.lists,
    DemosMaterial.menu,
    DemosMaterial.navDrawer,
    DemosMaterial.navRail,
    DemosMaterial.pickers,
    DemosMaterial.progressIndicator,
    DemosMaterial.selectionControls,
    DemosMaterial.sliders,
    DemosMaterial.snackbars,
    DemosMaterial.tabs,
    DemosMaterial.textField,
    DemosMaterial.tooltip,
  ];
}

class DemosMaterial {
  static LibraryLoader materialDemosLibrary = material_demos.loadLibrary;
  static GalleryRouterTest appBar = GalleryRouterTest(
    slug: 'app-bar',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoAppBarTitle,
      icon: GalleryIcons.appbar,
      slug: 'app-bar',
      subtitle: localizations.demoAppBarSubtitle,
      category: GalleryDemoCategory.material,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoAppBarTitle,
          description: localizations.demoAppBarDescription,
          documentationUrl: '$kDocsBaseUrl/material/AppBar-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.AppBarDemo(),
          ),
          code: CodeSegments.appbarDemo,
        ),
      ],
    ),
  );
  static GalleryRouterTest banner = GalleryRouterTest(
    slug: 'banner',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoBannerTitle,
      icon: GalleryIcons.listsLeaveBehind,
      slug: 'banner',
      subtitle: localizations.demoBannerSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoBannerTitle,
          description: localizations.demoBannerDescription,
          documentationUrl: '$kDocsBaseUrl/material/MaterialBanner-class.html',
          buildRoute: (_) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(text: 'BannerDemo'),
          ),
          code: CodeSegments.bannerDemo,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest bottomAppBar = GalleryRouterTest(
    slug: 'bottom-app-bar',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoBottomAppBarTitle,
      icon: GalleryIcons.bottomAppBar,
      slug: 'bottom-app-bar',
      subtitle: localizations.demoBottomAppBarSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoBottomAppBarTitle,
          description: localizations.demoBottomAppBarDescription,
          documentationUrl: '$kDocsBaseUrl/material/BottomAppBar-class.html',
          buildRoute: (_) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(text: 'BottomAppBarDemo'),
          ),
          code: CodeSegments.bottomAppBarDemo,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest bottomNavigation = GalleryRouterTest(
    slug: 'bottom-navigation',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoBottomNavigationTitle,
      icon: GalleryIcons.bottomNavigation,
      slug: 'bottom-navigation',
      subtitle: localizations.demoBottomNavigationSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoBottomNavigationPersistentLabels,
          description: localizations.demoBottomNavigationDescription,
          documentationUrl: '$kDocsBaseUrl/material/BottomNavigationBar-class.html',
          buildRoute: (_) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(text: 'BottomNavigationDemo'
                  // type: BottomNavigationDemoType.withLabels,
                  // restorationId: 'bottom_navigation_labels_demo',
                  )),
          code: CodeSegments.bottomNavigationDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoBottomNavigationSelectedLabel,
          description: localizations.demoBottomNavigationDescription,
          documentationUrl: '$kDocsBaseUrl/material/BottomNavigationBar-class.html',
          buildRoute: (_) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'BottomNavigationDemo',
                    // type: BottomNavigationDemoType.withoutLabels,
                    // restorationId: 'bottom_navigation_without_labels_demo',
                  )),
          code: CodeSegments.bottomNavigationDemo,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest bottomSheet = GalleryRouterTest(
    slug: 'bottom-sheet',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoBottomSheetTitle,
      icon: GalleryIcons.bottomSheets,
      slug: 'bottom-sheet',
      subtitle: localizations.demoBottomSheetSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoBottomSheetPersistentTitle,
          description: localizations.demoBottomSheetPersistentDescription,
          documentationUrl: '$kDocsBaseUrl/material/BottomSheet-class.html',
          buildRoute: (_) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'BottomSheetDemo',
                    // type: BottomSheetDemoType.persistent,
                  )),
          code: CodeSegments.bottomSheetDemoPersistent,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoBottomSheetModalTitle,
          description: localizations.demoBottomSheetModalDescription,
          documentationUrl: '$kDocsBaseUrl/material/BottomSheet-class.html',
          buildRoute: (_) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'BottomSheetDemo',
                    // type: BottomSheetDemoType.modal,
                  )),
          code: CodeSegments.bottomSheetDemoModal,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest button = GalleryRouterTest(
    slug: 'buttom',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoButtonTitle,
      icon: GalleryIcons.genericButtons,
      slug: 'button',
      subtitle: localizations.demoButtonSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoTextButtonTitle,
          description: localizations.demoTextButtonDescription,
          documentationUrl: '$kDocsBaseUrl/material/TextButton-class.html',
          buildRoute: (_) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'ButtonDemo',
                    // type: ButtonDemoType.text
                  )),
          code: CodeSegments.buttonDemoText,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoElevatedButtonTitle,
          description: localizations.demoElevatedButtonDescription,
          documentationUrl: '$kDocsBaseUrl/material/ElevatedButton-class.html',
          buildRoute: (_) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'ButtonDemo',
                    // type: ButtonDemoType.elevated
                  )),
          code: CodeSegments.buttonDemoElevated,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoOutlinedButtonTitle,
          description: localizations.demoOutlinedButtonDescription,
          documentationUrl: '$kDocsBaseUrl/material/OutlinedButton-class.html',
          buildRoute: (_) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'ButtonDemo',
                    // type: ButtonDemoType.outlined
                  )),
          code: CodeSegments.buttonDemoOutlined,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoToggleButtonTitle,
          description: localizations.demoToggleButtonDescription,
          documentationUrl: '$kDocsBaseUrl/material/ToggleButtons-class.html',
          buildRoute: (_) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'ButtonDemo',
                    // type: ButtonDemoType.toggle
                  )),
          code: CodeSegments.buttonDemoToggle,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoFloatingButtonTitle,
          description: localizations.demoFloatingButtonDescription,
          documentationUrl: '$kDocsBaseUrl/material/FloatingActionButton-class.html',
          buildRoute: (_) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'ButtonDemo',
                    // type: ButtonDemoType.floating
                  )),
          code: CodeSegments.buttonDemoFloating,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest card = GalleryRouterTest(
    slug: 'card',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoCardTitle,
      icon: GalleryIcons.cards,
      slug: 'card',
      subtitle: localizations.demoCardSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoCardTitle,
          description: localizations.demoCardDescription,
          documentationUrl: '$kDocsBaseUrl/material/Card-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(text: 'CardsDemo'),
          ),
          code: CodeSegments.cardsDemo,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest chip = GalleryRouterTest(
    slug: 'chip',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoChipTitle,
      icon: GalleryIcons.chips,
      slug: 'chip',
      subtitle: localizations.demoChipSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoActionChipTitle,
          description: localizations.demoActionChipDescription,
          documentationUrl: '$kDocsBaseUrl/material/ActionChip-class.html',
          buildRoute: (context) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'ChipDemo',
                    // type: ChipDemoType.action
                  )),
          code: CodeSegments.chipDemoAction,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoChoiceChipTitle,
          description: localizations.demoChoiceChipDescription,
          documentationUrl: '$kDocsBaseUrl/material/ChoiceChip-class.html',
          buildRoute: (context) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'ChipDemo',
                    // type: ChipDemoType.choice
                  )),
          code: CodeSegments.chipDemoChoice,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoFilterChipTitle,
          description: localizations.demoFilterChipDescription,
          documentationUrl: '$kDocsBaseUrl/material/FilterChip-class.html',
          buildRoute: (context) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'ChipDemo',
                    // type: ChipDemoType.filter
                  )),
          code: CodeSegments.chipDemoFilter,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoInputChipTitle,
          description: localizations.demoInputChipDescription,
          documentationUrl: '$kDocsBaseUrl/material/InputChip-class.html',
          buildRoute: (context) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'ChipDemo',
                    // type: ChipDemoType.input
                  )),
          code: CodeSegments.chipDemoInput,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest dataTable = GalleryRouterTest(
    slug: 'data-table',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoDataTableTitle,
      icon: GalleryIcons.dataTable,
      slug: 'data-table',
      subtitle: localizations.demoDataTableSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoDataTableTitle,
          description: localizations.demoDataTableDescription,
          documentationUrl: '$kDocsBaseUrl/material/DataTable-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(text: 'DataTableDemo'),
          ),
          code: CodeSegments.dataTableDemo,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest dialog = GalleryRouterTest(
    slug: 'dialog',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoDialogTitle,
      icon: GalleryIcons.dialogs,
      slug: 'dialog',
      subtitle: localizations.demoDialogSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoAlertDialogTitle,
          description: localizations.demoAlertDialogDescription,
          documentationUrl: '$kDocsBaseUrl/material/AlertDialog-class.html',
          buildRoute: (context) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'DialogDemo',
                    // type: DialogDemoType.alert
                  )),
          code: CodeSegments.dialogDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoAlertTitleDialogTitle,
          description: localizations.demoAlertDialogDescription,
          documentationUrl: '$kDocsBaseUrl/material/AlertDialog-class.html',
          buildRoute: (context) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'DialogDemo',
                    // type: DialogDemoType.alertTitle
                  )),
          code: CodeSegments.dialogDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoSimpleDialogTitle,
          description: localizations.demoSimpleDialogDescription,
          documentationUrl: '$kDocsBaseUrl/material/SimpleDialog-class.html',
          buildRoute: (context) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'DialogDemo',
                    // type: DialogDemoType.simple
                  )),
          code: CodeSegments.dialogDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoFullscreenDialogTitle,
          description: localizations.demoFullscreenDialogDescription,
          documentationUrl: '$kDocsBaseUrl/widgets/PageRoute/fullscreenDialog.html',
          buildRoute: (context) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'DialogDemo',
                    // type: DialogDemoType.fullscreen
                  )),
          code: CodeSegments.dialogDemo,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest divider = GalleryRouterTest(
    slug: 'divider',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoDividerTitle,
      icon: GalleryIcons.divider,
      slug: 'divider',
      subtitle: localizations.demoDividerSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoDividerTitle,
          description: localizations.demoDividerDescription,
          documentationUrl: '$kDocsBaseUrl/material/Divider-class.html',
          buildRoute: (_) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'DividerDemo',
                    // type: DividerDemoType.horizontal
                  )),
          code: CodeSegments.dividerDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoVerticalDividerTitle,
          description: localizations.demoDividerDescription,
          documentationUrl: '$kDocsBaseUrl/material/VerticalDivider-class.html',
          buildRoute: (_) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'DividerDemo',
                    // type: DividerDemoType.vertical
                  )),
          code: CodeSegments.verticalDividerDemo,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest gridLists = GalleryRouterTest(
    slug: 'grid-lists',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoGridListsTitle,
      icon: GalleryIcons.gridOn,
      slug: 'grid-lists',
      subtitle: localizations.demoGridListsSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoGridListsImageOnlyTitle,
          description: localizations.demoGridListsDescription,
          documentationUrl: '$kDocsBaseUrl/widgets/GridView-class.html',
          buildRoute: (context) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'GridListDemo',
                    // type: GridListDemoType.imageOnly
                  )),
          code: CodeSegments.gridListsDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoGridListsHeaderTitle,
          description: localizations.demoGridListsDescription,
          documentationUrl: '$kDocsBaseUrl/widgets/GridView-class.html',
          buildRoute: (context) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'GridListDemo',
                    // type: GridListDemoType.header
                  )),
          code: CodeSegments.gridListsDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoGridListsFooterTitle,
          description: localizations.demoGridListsDescription,
          documentationUrl: '$kDocsBaseUrl/widgets/GridView-class.html',
          buildRoute: (context) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'GridListDemo',
                    // type: GridListDemoType.footer
                  )),
          code: CodeSegments.gridListsDemo,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest lists = GalleryRouterTest(
    slug: 'lists',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoListsTitle,
      icon: GalleryIcons.listAlt,
      slug: 'lists',
      subtitle: localizations.demoListsSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoOneLineListsTitle,
          description: localizations.demoListsDescription,
          documentationUrl: '$kDocsBaseUrl/material/ListTile-class.html',
          buildRoute: (context) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'ListDemo',
                    // type: ListDemoType.oneLine
                  )),
          code: CodeSegments.listDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoTwoLineListsTitle,
          description: localizations.demoListsDescription,
          documentationUrl: '$kDocsBaseUrl/material/ListTile-class.html',
          buildRoute: (context) => DeferredWidget(
              materialDemosLibrary,
              () => material_demos.TodoText(
                    text: 'ListDemo',
                    // type: ListDemoType.twoLine
                  )),
          code: CodeSegments.listDemo,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest menu = GalleryRouterTest(
    slug: 'menu',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoMenuTitle,
      icon: GalleryIcons.moreVert,
      slug: 'menu',
      subtitle: localizations.demoMenuSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoContextMenuTitle,
          description: localizations.demoMenuDescription,
          documentationUrl: '$kDocsBaseUrl/material/PopupMenuItem-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(
              text: 'MenuDemo',
              // type: MenuDemoType.contextMenu
            ),
          ),
          code: CodeSegments.menuDemoContext,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoSectionedMenuTitle,
          description: localizations.demoMenuDescription,
          documentationUrl: '$kDocsBaseUrl/material/PopupMenuItem-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(
              text: 'MenuDemo',
              // type: MenuDemoType.sectionedMenu
            ),
          ),
          code: CodeSegments.menuDemoSectioned,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoChecklistMenuTitle,
          description: localizations.demoMenuDescription,
          documentationUrl: '$kDocsBaseUrl/material/CheckedPopupMenuItem-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(
              text: 'MenuDemo',
              // type: MenuDemoType.checklistMenu
            ),
          ),
          code: CodeSegments.menuDemoChecklist,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoSimpleMenuTitle,
          description: localizations.demoMenuDescription,
          documentationUrl: '$kDocsBaseUrl/material/PopupMenuItem-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(
              text: 'MenuDemo',
              // type: MenuDemoType.simpleMenu
            ),
          ),
          code: CodeSegments.menuDemoSimple,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest navDrawer = GalleryRouterTest(
    slug: 'nav_drawer',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoNavigationDrawerTitle,
      icon: GalleryIcons.menu,
      slug: 'nav_drawer',
      subtitle: localizations.demoNavigationDrawerSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoNavigationDrawerTitle,
          description: localizations.demoNavigationDrawerDescription,
          documentationUrl: '$kDocsBaseUrl/material/Drawer-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(text: 'NavDrawerDemo'),
          ),
          code: CodeSegments.navDrawerDemo,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest navRail = GalleryRouterTest(
    slug: 'nav_rail',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoNavigationRailTitle,
      icon: GalleryIcons.navigationRail,
      slug: 'nav_rail',
      subtitle: localizations.demoNavigationRailSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoNavigationRailTitle,
          description: localizations.demoNavigationRailDescription,
          documentationUrl: '$kDocsBaseUrl/material/NavigationRail-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(text: 'NavRailDemo'),
          ),
          code: CodeSegments.navRailDemo,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest pickers = GalleryRouterTest(
    slug: 'pickers',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoPickersTitle,
      icon: GalleryIcons.event,
      slug: 'pickers',
      subtitle: localizations.demoPickersSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoDatePickerTitle,
          description: localizations.demoDatePickerDescription,
          documentationUrl: '$kDocsBaseUrl/material/showDatePicker.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(
              text: 'PickerDemo',
              // type: PickerDemoType.date
            ),
          ),
          code: CodeSegments.pickerDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoTimePickerTitle,
          description: localizations.demoTimePickerDescription,
          documentationUrl: '$kDocsBaseUrl/material/showTimePicker.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(
              text: 'PickerDemo',
              // type: PickerDemoType.time
            ),
          ),
          code: CodeSegments.pickerDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoDateRangePickerTitle,
          description: localizations.demoDateRangePickerDescription,
          documentationUrl: '$kDocsBaseUrl/material/showDateRangePicker.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(
              text: 'PickerDemo',
              // type: PickerDemoType.range
            ),
          ),
          code: CodeSegments.pickerDemo,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest progressIndicator = GalleryRouterTest(
    slug: 'progress-indicator',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoProgressIndicatorTitle,
      icon: GalleryIcons.progressActivity,
      slug: 'progress-indicator',
      subtitle: localizations.demoProgressIndicatorSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoCircularProgressIndicatorTitle,
          description: localizations.demoCircularProgressIndicatorDescription,
          documentationUrl: '$kDocsBaseUrl/material/CircularProgressIndicator-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(
              text: 'ProgressIndicatorDemo',
              // type: ProgressIndicatorDemoType.circular,
            ),
          ),
          code: CodeSegments.progressIndicatorsDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoLinearProgressIndicatorTitle,
          description: localizations.demoLinearProgressIndicatorDescription,
          documentationUrl: '$kDocsBaseUrl/material/LinearProgressIndicator-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(
              text: 'ProgressIndicatorDemo',
              // type: ProgressIndicatorDemoType.linear,
            ),
          ),
          code: CodeSegments.progressIndicatorsDemo,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest selectionControls = GalleryRouterTest(
    slug: 'selection-controls',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoSelectionControlsTitle,
      icon: GalleryIcons.checkBox,
      slug: 'selection-controls',
      subtitle: localizations.demoSelectionControlsSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoSelectionControlsCheckboxTitle,
          description: localizations.demoSelectionControlsCheckboxDescription,
          documentationUrl: '$kDocsBaseUrl/material/Checkbox-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(
              text: 'SelectionControlsDemo',
              // type: SelectionControlsDemoType.checkbox,
            ),
          ),
          code: CodeSegments.selectionControlsDemoCheckbox,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoSelectionControlsRadioTitle,
          description: localizations.demoSelectionControlsRadioDescription,
          documentationUrl: '$kDocsBaseUrl/material/Radio-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(
              text: 'SelectionControlsDemo',
              // type: SelectionControlsDemoType.radio,
            ),
          ),
          code: CodeSegments.selectionControlsDemoRadio,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoSelectionControlsSwitchTitle,
          description: localizations.demoSelectionControlsSwitchDescription,
          documentationUrl: '$kDocsBaseUrl/material/Switch-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(
              text: 'SelectionControlsDemo',
              // type: SelectionControlsDemoType.switches,
            ),
          ),
          code: CodeSegments.selectionControlsDemoSwitches,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest sliders = GalleryRouterTest(
    slug: 'sliders',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoSlidersTitle,
      icon: GalleryIcons.sliders,
      slug: 'sliders',
      subtitle: localizations.demoSlidersSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoSlidersTitle,
          description: localizations.demoSlidersDescription,
          documentationUrl: '$kDocsBaseUrl/material/Slider-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(
              text: 'SlidersDemo',
              // type: SlidersDemoType.sliders
            ),
          ),
          code: CodeSegments.slidersDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoRangeSlidersTitle,
          description: localizations.demoRangeSlidersDescription,
          documentationUrl: '$kDocsBaseUrl/material/RangeSlider-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(
              text: 'SlidersDemo',
              // type: SlidersDemoType.rangeSliders
            ),
          ),
          code: CodeSegments.rangeSlidersDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoCustomSlidersTitle,
          description: localizations.demoCustomSlidersDescription,
          documentationUrl: '$kDocsBaseUrl/material/SliderTheme-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(
              text: 'SlidersDemo',
              // type: SlidersDemoType.customSliders
            ),
          ),
          code: CodeSegments.customSlidersDemo,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest snackbars = GalleryRouterTest(
    slug: 'snackbars',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoSnackbarsTitle,
      icon: GalleryIcons.snackbar,
      slug: 'snackbars',
      subtitle: localizations.demoSnackbarsSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoSnackbarsTitle,
          description: localizations.demoSnackbarsDescription,
          documentationUrl: '$kDocsBaseUrl/material/SnackBar-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(text: 'SnackbarsDemo'),
          ),
          code: CodeSegments.snackbarsDemo,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest tabs = GalleryRouterTest(
    slug: 'tabs',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoTabsTitle,
      icon: GalleryIcons.tabs,
      slug: 'tabs',
      subtitle: localizations.demoTabsSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoTabsScrollingTitle,
          description: localizations.demoTabsDescription,
          documentationUrl: '$kDocsBaseUrl/material/TabBar-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(
              text: 'TabsDemo',
              // type: TabsDemoType.scrollable
            ),
          ),
          code: CodeSegments.tabsScrollableDemo,
        ),
        GalleryDemoConfiguration(
          title: localizations.demoTabsNonScrollingTitle,
          description: localizations.demoTabsDescription,
          documentationUrl: '$kDocsBaseUrl/material/TabBar-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(
              text: 'TabsDemo',
              // type: TabsDemoType.nonScrollable
            ),
          ),
          code: CodeSegments.tabsNonScrollableDemo,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest textField = GalleryRouterTest(
    slug: 'text-field',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoTextFieldTitle,
      icon: GalleryIcons.textFieldsAlt,
      slug: 'text-field',
      subtitle: localizations.demoTextFieldSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoTextFieldTitle,
          description: localizations.demoTextFieldDescription,
          documentationUrl: '$kDocsBaseUrl/material/TextField-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(text: 'TextFieldDemo'),
          ),
          code: CodeSegments.textFieldDemo,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
  static GalleryRouterTest tooltip = GalleryRouterTest(
    slug: 'tooltip',
    widget: (localizations) => GalleryDemo(
      title: localizations.demoTooltipTitle,
      icon: GalleryIcons.tooltip,
      slug: 'tooltip',
      subtitle: localizations.demoTooltipSubtitle,
      configurations: [
        GalleryDemoConfiguration(
          title: localizations.demoTooltipTitle,
          description: localizations.demoTooltipDescription,
          documentationUrl: '$kDocsBaseUrl/material/Tooltip-class.html',
          buildRoute: (context) => DeferredWidget(
            materialDemosLibrary,
            () => material_demos.TodoText(
              text: 'TooltipDemo',
            ),
          ),
          code: CodeSegments.tooltipDemo,
        ),
      ],
      category: GalleryDemoCategory.material,
    ),
  );
}

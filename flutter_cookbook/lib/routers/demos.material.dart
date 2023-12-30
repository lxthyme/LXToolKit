import 'package:flutter_cookbook/gallery/constants.dart';
import 'package:flutter_cookbook/gallery/demos/material/material_demos.dart' deferred as material_demos;
import 'package:flutter_cookbook/gallery/codeviewer/code_segments.dart';
import 'package:flutter_cookbook/gallery/data/demos.dart';
import 'package:flutter_cookbook/gallery/data/icons.dart';
import 'package:flutter_cookbook/gallery/deferred_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension DemosMaterialAll on DemosMaterial {
  static List<GalleryDemo> materialList(AppLocalizations localizations) {
    return [
      DemosMaterial.appBar(localizations),
    ];
  }
}

class DemosMaterial {
  static LibraryLoader materialDemosLibrary = material_demos.loadLibrary;
  static GalleryDemo appBar(AppLocalizations localizations) => GalleryDemo(
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
      );
  // static GalleryDemo t(AppLocalizations localizations) =>
}
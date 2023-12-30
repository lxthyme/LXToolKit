import 'package:flutter_cookbook/gallery/data/demos.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension DemosBannerAll on DemosBanner {
  static Map<String, GalleryDemo> studies(AppLocalizations localizations) => <String, GalleryDemo>{
        'shrine': DemosBanner.shrine(localizations),
      };
}

class DemosBanner {
  static GalleryDemo shrine(AppLocalizations localizations) => GalleryDemo(
        title: 'Shrine',
        subtitle: localizations.shrineDescription,
        category: GalleryDemoCategory.study,
        studyId: 'shrine',
      );
  // static GalleryDemo t(AppLocalizations localizations) =>
}

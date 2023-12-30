import 'package:flutter_cookbook/gallery/data/demos.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension DemosBannerAll on DemosBanner {
  static Map<String, GalleryRouterTest> studies = {
    'shrine': DemosBanner.shrine,
  };
}

class DemosBanner {
  static GalleryRouterTest shrine = GalleryRouterTest(
    studyId: 'shrine',
    widget: (AppLocalizations localizations) => GalleryDemo(
      title: 'Shrine',
      subtitle: localizations.shrineDescription,
      category: GalleryDemoCategory.study,
      studyId: 'shrine',
    ),
  );
  // static GalleryDemo t(AppLocalizations localizations) =>
}

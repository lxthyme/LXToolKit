import 'package:flutter_cookbook/gallery/data/demos.dart';

extension DemosBannerAll on DemosBanner {
  static Map<String, GalleryRouterTest> studies = {
    'shrine': DemosBanner.shrine,
  };
}

class DemosBanner {
  static GalleryRouterTest shrine = GalleryRouterTest(
    studyId: 'shrine',
    widget: (localizations) => GalleryDemo(
      title: 'Shrine',
      subtitle: localizations.shrineDescription,
      category: GalleryDemoCategory.study,
      studyId: 'shrine',
    ),
  );
  // static GalleryDemo t(GalleryLocalizations localizations) =>
}

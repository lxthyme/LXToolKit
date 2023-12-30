import 'package:flutter_cookbook/gallery/data/demos.dart';

extension DemosBannerAll on DemosBanner {
  static Map<String, GalleryRouterTest> studies = {
    'shrine': DemosBanner.shrine,
    'rally': DemosBanner.rally,
    'crane': DemosBanner.crane,
    'fortnightly': DemosBanner.fortnightly,
    'reply': DemosBanner.reply,
    'starterApp': DemosBanner.starterApp,
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
  static GalleryRouterTest rally = GalleryRouterTest(
    studyId: 'rally',
    widget: (localizations) => GalleryDemo(
      title: 'Rally',
      subtitle: localizations.rallyDescription,
      category: GalleryDemoCategory.study,
      studyId: 'rally',
    ),
  );
  static GalleryRouterTest crane = GalleryRouterTest(
    studyId: 'crane',
    widget: (localizations) => GalleryDemo(
      title: 'Crane',
      subtitle: localizations.craneDescription,
      category: GalleryDemoCategory.study,
      studyId: 'crane',
    ),
  );
  static GalleryRouterTest fortnightly = GalleryRouterTest(
    studyId: 'fortnightly',
    widget: (localizations) => GalleryDemo(
      title: 'Fortnightly',
      subtitle: localizations.fortnightlyDescription,
      category: GalleryDemoCategory.study,
      studyId: 'fortnightly',
    ),
  );
  static GalleryRouterTest reply = GalleryRouterTest(
    studyId: 'reply',
    widget: (localizations) => GalleryDemo(
      title: 'Reply',
      subtitle: localizations.replyDescription,
      category: GalleryDemoCategory.study,
      studyId: 'reply',
    ),
  );
  static GalleryRouterTest starterApp = GalleryRouterTest(
    studyId: 'starterApp',
    widget: (localizations) => GalleryDemo(
      title: localizations.starterAppTitle,
      subtitle: localizations.starterAppDescription,
      category: GalleryDemoCategory.study,
      studyId: 'starter',
    ),
  );
  // static GalleryDemo t(GalleryLocalizations localizations) =>
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_cookbook/gallery/cupertino/codeviewer/code_displayer.dart';

enum GalleryDemoCategory {
  study,
  material,
  cupertino,
  other;

  @override
  String toString() {
    return name.toUpperCase();
  }

  String? displayTitle(AppLocalizations localizations) {
// switch (this) {
//   case GalleryDemoCategory.other:
//   return localizations.
// }
    return null;
  }
}

class GalleryDemo {
  const GalleryDemo({
    required this.title,
    required this.category,
    required this.subtitle,
    this.studyId,
    this.slug,
    this.icon,
    this.configurations = const [],
  }); // : assert(category == Gal);

  final String title;
  final GalleryDemoConfiguration category;
  final String subtitle;
  final String? studyId;
  final String? slug;
  final IconData? icon;
  final List<GalleryDemoConfiguration> configurations;

  String get describe => '${slug ?? studyId}@${category.name}';
}

class GalleryDemoConfiguration {
  const GalleryDemoConfiguration({
    required this.title,
    required this.description,
    required this.documentationUrl,
    required this.buildRoute,
    required this.code,
  });

  final String title;
  final String description;
  final String documentationUrl;
  final WidgetBuilder buildRoute;
  final CodeDisplayer code;
}

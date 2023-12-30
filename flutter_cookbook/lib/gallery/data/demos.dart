import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cookbook/gallery/codeviewer/code_displayer.dart';
import 'package:flutter_cookbook/routers/demos.banner.dart';
import 'package:flutter_cookbook/routers/demos.cupertino.dart';
import 'package:flutter_cookbook/routers/demos.daily.dart';
import 'package:flutter_cookbook/routers/demos.material.dart';
import 'package:flutter_cookbook/routers/demos.others.dart';
import 'package:flutter_cookbook/gallery/pages/demo.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations_en.dart';

enum GalleryDemoCategory {
  daily,
  study,
  material,
  cupertino,
  other;

  @override
  String toString() {
    return name.toUpperCase();
  }

  String? displayTitle(GalleryLocalizations localizations) {
    switch (this) {
      case GalleryDemoCategory.other:
        return localizations.homeCategoryReference;
      case GalleryDemoCategory.daily:
      case GalleryDemoCategory.material:
      case GalleryDemoCategory.cupertino:
        return toString();
      case GalleryDemoCategory.study:
    }
    return null;
  }
}

class GalleryRouterTest {
  final String? studyId;
  final String baseRoute;
  final String? slug;
  // final GalleryDemo widget;
  final GalleryDemo Function(GalleryLocalizations localizations) widget;

  const GalleryRouterTest({
    this.baseRoute = DemoPage.baseRoute,
    this.slug,
    this.studyId,
    required this.widget,
  }) : assert(slug != null || studyId != null);
}

class GalleryDemo {
  const GalleryDemo({
    required this.title,
    required this.category,
    required this.subtitle,
    this.studyId,
    this.baseRoute = DemoPage.baseRoute,
    this.slug,
    this.icon,
    this.configurations = const [],
  })  : assert(category == GalleryDemoCategory.study || (slug != null && icon != null)),
        assert(slug != null || studyId != null);

  final String title;
  final GalleryDemoCategory category;
  final String subtitle;
  final String? studyId;
  final String baseRoute;
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

class Demos {
  static Map<String?, GalleryDemo> asSlugToDemoMap(BuildContext context) {
    final localizations = GalleryLocalizations.of(context)!;
    return LinkedHashMap<String?, GalleryDemo>.fromIterable(
      all.map((e) => e.widget(localizations)),
      key: (dynamic demo) => demo.slug as String?,
    );
  }

  static List<GalleryRouterTest> all = DemosBannerAll.studies.values.toList() +
      DemosDailyAll.dailyList +
      DemosMaterialAll.materialList +
      DemosCupertinoAll.cupertinoList +
      DemosOthersAll.otherList;

  static List<String> allDescriptions() =>
      all.map((e) => e.widget(GalleryLocalizationsEn())).map((e) => e.describe).toList();
}

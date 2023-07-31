import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cookbook/gallery/pages/demo.dart';
// import 'package:flutter_cookbook/gallery/galleryRoot.dart';
import 'package:flutter_cookbook/main.dart';

typedef PathWidgetBuilder = Widget Function(BuildContext, String?);

class Path {
  const Path(this.pattern, this.builder, {this.openInSecondScreen = false});

  final String pattern;
  final PathWidgetBuilder builder;
  final bool openInSecondScreen;
}

class RouteConfiguration {
  static List<Path> paths = [
    Path(
      r'^' + DemoPage.baseRoute + r'/([\w-]+)$',
      (context, match) => DemoPage(slug: match),
      openInSecondScreen: false,
    ),
    // Path(
    //   r'^' + '/gallery' + r'/([\w-]+)$',
    //   (context, match) =>
    // ),
    Path(
      r'^/',
      (context, match) => const GalleryRootPage(),
      openInSecondScreen: false,
    )
  ];

  static Route<dynamic>? onGenerateRoute(
    RouteSettings settings,
    bool hasHinge,
  ) {
    for (final path in paths) {
      final regExpPattern = RegExp(path.pattern);
      if (regExpPattern.hasMatch(settings.name!)) {
        final firstMatch = regExpPattern.firstMatch(settings.name!)!;
        final match = (firstMatch.groupCount == 1) ? firstMatch.group(1) : null;
        if (kIsWeb) {
          return NoAnimationMaterialPageRoute<void>(
            builder: (context) => path.builder(context, match),
            settings: settings,
          );
        }
        if (path.openInSecondScreen && hasHinge) {
          return TwoPanePageRoute<void>(
            builder: (context) => path.builder(context, match),
            settings: settings,
          );
        } else {
          return MaterialPageRoute<void>(
            builder: (context) => path.builder(context, match),
            settings: settings,
          );
        }
      }
    }

    return null;
  }
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    required super.builder,
    super.settings,
  });

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

class TwoPanePageRoute<T> extends OverlayRoute<T> {
  TwoPanePageRoute({
    required this.builder,
    super.settings,
  });

  final WidgetBuilder builder;

  @override
  Iterable<OverlayEntry> createOverlayEntries() sync* {
    yield OverlayEntry(
      builder: (context) {
        final hinge = MediaQuery.of(context).hinge?.bounds;
        if (hinge == null) {
          return builder.call(context);
        } else {
          return Positioned(
            top: 0,
            left: hinge.right,
            right: 0,
            bottom: 0,
            child: builder.call(context),
          );
        }
      },
    );
  }
}

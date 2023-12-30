import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';

class CupertinoNavigationBarDemo extends StatelessWidget {
  const CupertinoNavigationBarDemo({super.key});

  static const String homeRoute = '/home';
  static const String secondPageRoute = '/home/item';

  @override
  Widget build(BuildContext context) {
    return Navigator(
      restorationScopeId: 'navigator',
      initialRoute: CupertinoNavigationBarDemo.homeRoute,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case CupertinoNavigationBarDemo.homeRoute:
            return _NoAnimationCupertinoPageRoute(
              title: GalleryLocalizations.of(context)!.demoCupertinoTabBarTitle,
              settings: settings,
              builder: (context) => const _FirstPage(),
            );
          case CupertinoNavigationBarDemo.secondPageRoute:
            final arguments = settings.arguments as Map<dynamic, dynamic>;
            final title = arguments['pageTitle'] as String?;
            return CupertinoPageRoute(
              title: title,
              settings: settings,
              builder: (context) => const _SecondPage(),
            );
        }
      },
    );
  }
}

class _FirstPage extends StatelessWidget {
  const _FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            automaticallyImplyLeading: false,
          ),
          SliverPadding(
            padding: MediaQuery.of(context).removePadding(removeTop: true).padding,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final title = GalleryLocalizations.of(context)!.starterAppDrawerItem(index + 1);
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).restorablePushNamed(
                        CupertinoNavigationBarDemo.secondPageRoute,
                        arguments: {'pageTitle': title},
                      );
                    },
                    title: Text(title),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecondPage extends StatelessWidget {
  const _SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      child: Container(),
    );
  }
}

class _NoAnimationCupertinoPageRoute<T> extends CupertinoPageRoute<T> {
  _NoAnimationCupertinoPageRoute({required super.builder, super.settings, super.title});

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

import 'package:flutter/cupertino.dart';

import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';

class _TabInfo {
  final String title;
  final IconData icon;

  const _TabInfo(this.title, this.icon);
}

class CupertinoTabBarDemo extends StatelessWidget {
  const CupertinoTabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = GalleryLocalizations.of(context)!;
    final tabInfo = [
      _TabInfo(
        localizations.cupertinoTabBarHomeTab,
        CupertinoIcons.home,
      ),
      _TabInfo(
        localizations.cupertinoTabBarChatTab,
        CupertinoIcons.conversation_bubble,
      ),
      _TabInfo(
        localizations.cupertinoTabBarProfileTab,
        CupertinoIcons.profile_circled,
      ),
    ];
    return DefaultTextStyle(
      style: CupertinoTheme.of(context).textTheme.textStyle,
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: [
          for (final tabInfo in tabInfo)
            BottomNavigationBarItem(
              icon: Icon(tabInfo.icon),
              label: tabInfo.title,
            ),
        ]),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            restorationScopeId: "cupertino_tab_view_$index",
            builder: (context) => _CupertinoDemoTab(
              title: tabInfo[index].title,
              icon: tabInfo[index].icon,
            ),
          );
        },
      ),
    );
  }
}

class _CupertinoDemoTab extends StatelessWidget {
  const _CupertinoDemoTab({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      backgroundColor: CupertinoColors.systemBackground,
      child: Center(
        child: Icon(
          icon,
          semanticLabel: title,
          size: 100,
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_cookbook/gallery/pages/category_list_item.dart';
import 'package:flutter_cookbook/gallery/pages/splash.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_cookbook/gallery/constants.dart';
import 'package:flutter_cookbook/gallery/data/demos.dart';
import 'package:flutter_cookbook/gallery/data/gallery_options.dart';
import 'package:flutter_cookbook/gallery/layout/adaptive.dart';
import 'package:flutter_cookbook/gallery/studies/reply/routes.dart' as reply_routes;

const _horizontalPadding = 32.0;
const _horizontalDesktopPadding = 81.0;
const _carouselHeightMin = 240.0;
const _carouselItemDesktopMargin = 8.0;
const _carouselItemMobileMargin = 4.0;
const _carouselItemWidth = 296.0;

class ToggleSplashNotification extends Notification {}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final localizations = AppLocalizations.of(context)!;
    final studyDemos = Demos.studies(localizations);
    final carouselCards = <Widget>[
      _CarouselCard(
        demo: studyDemos['reply'],
        asset: const AssetImage(
          'assets/studies/reply_card.png',
          package: 'flutter_gallery_assets',
        ),
        assetColor: const Color(0xFF344955),
        assetDark: const AssetImage(
          'assets/studies/reply_card_dark.png',
          package: 'flutter_gallery_assets',
        ),
        assetDarkColor: const Color(0xFF1D2327),
        textColor: Colors.white,
        studyRoute: reply_routes.homeRoute,
      ),
    ];

    if (isDesktop) {
      print('-->home.dart > isDesktop');
      final desktopCategoryItems = <_DesktopCategoryItem>[
        _DesktopCategoryItem(
          category: GalleryDemoCategory.material,
          asset: const AssetImage(
            'assets/icons/material/material.png',
            package: 'flutter_gallery_assets',
          ),
          demos: Demos.materialDemos(localizations),
        ),
      ];
      return Scaffold(
        body: ListView(
          key: const ValueKey('HomeListView'),
          primary: true,
          padding: const EdgeInsetsDirectional.only(
            top: firstHeaderDesktopTopPadding,
          ),
          children: const [
            _DesktopHomeItem(child: _GalleryHeader()),
          ],
        ),
      );
    } else {
      print('-->home.dart > !isDesktop');
      return Scaffold(
        body: _AnimatedHomePage(
          restorationId: 'animated_page',
          isSplashPageAnimationFinished: SplashPageAnimation.of(context)!.isFinished,
          // isSplashPageAnimationFinished: false,
          carouselCards: carouselCards,
        ),
      );
    }
  }

  List<Widget> spaceBetween(double paddingBetween, List<Widget> children) {
    return [
      for (int idx = 0; idx < children.length; idx++) ...[
        Flexible(
          child: children[idx],
        ),
        if (idx < children.length - 1) SizedBox(width: paddingBetween),
      ],
    ];
  }
}

class _GalleryHeader extends StatelessWidget {
  const _GalleryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Header(
      color: Theme.of(context).colorScheme.primaryContainer,
      text: AppLocalizations.of(context)!.homeHeaderGallery,
    );
  }
}

class _CategoriesHeader extends StatelessWidget {
  const _CategoriesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Header(
      color: Theme.of(context).colorScheme.primary,
      text: AppLocalizations.of(context)!.homeHeaderCategories,
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.color,
    required this.text,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsets.only(
          top: isDisplayDesktop(context) ? 63 : 15,
          bottom: isDisplayDesktop(context) ? 21 : 11,
        ),
        child: SelectableText(
          text,
          style: Theme.of(context).textTheme.headlineMedium!.apply(
                color: color,
                fontSizeDelta: isDisplayDesktop(context) ? desktopDisplay1FontDelta : 0,
              ),
        ),
      ),
    );
  }
}

class _AnimatedHomePage extends StatefulWidget {
  const _AnimatedHomePage({
    required this.restorationId,
    required this.carouselCards,
    required this.isSplashPageAnimationFinished,
  });

  final String restorationId;
  final List<Widget> carouselCards;
  final bool isSplashPageAnimationFinished;

  @override
  State<_AnimatedHomePage> createState() => __AnimatedHomePageState();
}

class __AnimatedHomePageState extends State<_AnimatedHomePage> with RestorationMixin, SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Timer? _launchTimer;
  final RestorableBool _isMaterialListExpanded = RestorableBool(false);
  final RestorableBool _isCupertinoListExpaned = RestorableBool(false);
  final RestorableBool _isOtherListExpanded = RestorableBool(false);

  @override
  String get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_isMaterialListExpanded, 'material_lsit');
    registerForRestoration(_isCupertinoListExpaned, 'cupertino_list');
    registerForRestoration(_isOtherListExpanded, 'other_list');
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    if (widget.isSplashPageAnimationFinished) {
      _animationController.value = 1.0;
    } else {
      _launchTimer = Timer(
        halfSplashPageAnimationDuration,
        () {
          _animationController.forward();
        },
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _launchTimer?.cancel();
    _launchTimer = null;
    _isMaterialListExpanded.dispose();
    _isCupertinoListExpaned.dispose();
    _isOtherListExpanded.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final localizations = AppLocalizations.of(context);
    // final isTestModel = GalleryOptions.of(context).isTestMode;

    return Stack(
      children: [
        // const Text('home.dart'),
        ListView(
          key: const ValueKey('HomeListView'),
          primary: true,
          restorationId: 'home_list_view',
          children: [
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: const _GalleryHeader(),
            ),
            // Mobi
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.velocity.pixelsPerSecond.dy > 200) {
                ToggleSplashNotification().dispatch(context);
              }
            },
            child: SafeArea(
              child: Container(
                height: 40,
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DesktopHomeItem extends StatelessWidget {
  const _DesktopHomeItem({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: maxHomeItemWidth),
        padding: const EdgeInsets.symmetric(horizontal: _horizontalDesktopPadding),
        child: child,
      ),
    );
  }
}

class _DesktopCategoryItem extends StatelessWidget {
  const _DesktopCategoryItem({
    required this.category,
    required this.asset,
    required this.demos,
  });

  final GalleryDemoCategory category;
  final ImageProvider asset;
  final List<GalleryDemo> demos;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      color: colorScheme.surface,
      child: Semantics(
        container: true,
        child: FocusTraversalGroup(
          policy: WidgetOrderTraversalPolicy(),
          child: Column(
            children: [
              _DesktopCategoryHeader(
                category: category,
                asset: asset,
              ),
              Divider(
                height: 2,
                thickness: 2,
                color: colorScheme.background,
              ),
              Flexible(
                child: ListView.builder(
                  itemBuilder: (context, index) => CategoryDemoItem(demo: demos[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopCategoryHeader extends StatelessWidget {
  const _DesktopCategoryHeader({
    required this.category,
    required this.asset,
  });

  final GalleryDemoCategory category;
  final ImageProvider asset;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      key: ValueKey('${category.name}CategoryHeader'),
      color: colorScheme.onBackground,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: FadeInImage(
              image: asset,
              placeholder: MemoryImage(kTransparentImage),
              fadeInDuration: entranceAnimationDuration,
              width: 64,
              height: 64,
              excludeFromSemantics: true,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 8),
              child: Semantics(
                header: true,
                child: SelectableText(
                  category.displayTitle(AppLocalizations.of(context)!)!,
                  style: Theme.of(context).textTheme.headlineSmall!.apply(
                        color: colorScheme.onSurface,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CarouselCard extends StatelessWidget {
  const _CarouselCard({
    required this.demo,
    this.asset,
    this.assetDark,
    this.assetColor,
    this.assetDarkColor,
    this.textColor,
    required this.studyRoute,
  });

  final GalleryDemo? demo;
  final ImageProvider? asset;
  final ImageProvider? assetDark;
  final Color? assetColor;
  final Color? assetDarkColor;
  final Color? textColor;
  final String studyRoute;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).colorScheme.brightness == Brightness.dark;
    final asset = isDark ? assetDark : this.asset;
    final assetColor = isDark ? assetDarkColor : this.assetColor;
    final textColor = isDark ? Colors.white.withOpacity(0.87) : this.textColor;
    final isDesktop = isDisplayDesktop(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? _carouselItemDesktopMargin : _carouselItemMobileMargin),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      height: _carouselHeight(0.7, context),
      width: _carouselItemWidth,
      child: Material(
        key: ValueKey(demo!.describe),
        color: assetColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (asset != null)
              FadeInImage(
                image: asset,
                placeholder: MemoryImage(kTransparentImage),
                fit: BoxFit.cover,
                height: _carouselHeightMin,
                fadeInDuration: entranceAnimationDuration,
              ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    demo!.title,
                    style: textTheme.bodySmall!.apply(color: textColor),
                    maxLines: 3,
                    overflow: TextOverflow.visible,
                  ),
                  Text(
                    demo!.subtitle,
                    style: textTheme.labelSmall!.apply(color: textColor),
                    maxLines: 5,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).popUntil((route) => route.settings.name == '/');
                    Navigator.of(context).restorablePushNamed(studyRoute);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

double _carouselHeight(double scaleFactor, BuildContext context) => math.max(
    _carouselHeightMin * GalleryOptions.of(context).textScaleFactor(context) * scaleFactor, _carouselHeightMin);

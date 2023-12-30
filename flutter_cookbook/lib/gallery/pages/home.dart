// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_cookbook/gallery/constants.dart';
import 'package:flutter_cookbook/gallery/data/demos.dart';
import 'package:flutter_cookbook/gallery/data/gallery_options.dart';
import 'package:flutter_cookbook/gallery/layout/adaptive.dart';
import 'package:flutter_cookbook/gallery/pages/category_list_item.dart';
import 'package:flutter_cookbook/gallery/pages/splash.dart';
// import 'package:flutter_cookbook/gallery/studies/reply/routes.dart' as reply_routes;
import 'package:flutter_cookbook/gallery/studies/shrine/colors.dart';
import 'package:flutter_cookbook/gallery/studies/shrine/routes.dart' as shrine_routes;
import 'package:flutter_cookbook/routers/demos.banner.dart';
import 'package:flutter_cookbook/routers/demos.cupertino.dart';
import 'package:flutter_cookbook/routers/demos.daily.dart';
import 'package:flutter_cookbook/routers/demos.material.dart';
import 'package:flutter_cookbook/routers/demos.others.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';

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
    final localizations = GalleryLocalizations.of(context)!;
    final studyDemos = DemosBannerAll.studies;
    final carouselCards = <Widget>[
      _CarouselCard(
        demo: studyDemos['shrine']?.widget(localizations),
        asset: const AssetImage(
          'assets/studies/shrine_card.png',
          package: 'flutter_gallery_assets',
        ),
        assetColor: const Color(0xFFFEDBD0),
        assetDark: const AssetImage(
          'assets/studies/shrine_card_dark.png',
          package: 'flutter_gallery_assets',
        ),
        assetDarkColor: const Color(0xFF543B3C),
        textColor: shrineBrown900,
        studyRoute: shrine_routes.loginRoute,
      ),
    ];

    if (isDesktop) {
      debugPrint('-->home.dart > isDesktop');
      final desktopCategoryItems = <_DesktopCategoryItem>[
        _DesktopCategoryItem(
          category: GalleryDemoCategory.material,
          asset: const AssetImage(
            'assets/icons/material/material.png',
            package: 'flutter_gallery_assets',
          ),
          demos: DemosMaterialAll.materialList.map((e) => e.widget(localizations)).toList(),
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
      debugPrint('-->home.dart > !isDesktop');
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
  const _GalleryHeader();

  @override
  Widget build(BuildContext context) {
    return Header(
      color: Theme.of(context).colorScheme.primaryContainer,
      text: GalleryLocalizations.of(context)!.homeHeaderGallery,
    );
  }
}

class _CategoriesHeader extends StatelessWidget {
  const _CategoriesHeader();

  @override
  Widget build(BuildContext context) {
    return Header(
      color: Theme.of(context).colorScheme.primary,
      text: GalleryLocalizations.of(context)!.homeHeaderCategories,
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
  final RestorableBool _isDailyListExpanded = RestorableBool(false);
  final RestorableBool _isMaterialListExpanded = RestorableBool(false);
  final RestorableBool _isCupertinoListExpaned = RestorableBool(false);
  final RestorableBool _isOtherListExpanded = RestorableBool(false);

  @override
  String get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_isDailyListExpanded, 'daily_lsit');
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
    _isDailyListExpanded.dispose();
    _isMaterialListExpanded.dispose();
    _isCupertinoListExpaned.dispose();
    _isOtherListExpanded.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = GalleryLocalizations.of(context)!;
    final isTestModel = GalleryOptions.of(context).isTestMode;

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
            _ModbileCarousel(
              animationController: _animationController,
              restorationId: 'home_carousel',
              children: widget.carouselCards,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: const _CategoriesHeader(),
            ),
            _AnimatedCategoryItem(
              startDelayFraction: 0.00,
              controller: _animationController,
              child: CategoryListItem(
                key: const PageStorageKey<GalleryDemoCategory>(
                  GalleryDemoCategory.daily,
                ),
                restorationId: 'home_daily_list',
                category: GalleryDemoCategory.daily,
                imageString: 'assets/icons/material/material.png',
                demos: DemosDailyAll.dailyList.map((e) => e.widget(localizations)).toList(),
                initiallyExpanded: _isDailyListExpanded.value || isTestModel,
                onTap: (shouldOpenList) {
                  _isDailyListExpanded.value = shouldOpenList;
                },
              ),
            ),
            _AnimatedCategoryItem(
              startDelayFraction: 0.00,
              controller: _animationController,
              child: CategoryListItem(
                key: const PageStorageKey<GalleryDemoCategory>(
                  GalleryDemoCategory.material,
                ),
                restorationId: 'home_material_category_list',
                category: GalleryDemoCategory.material,
                imageString: 'assets/icons/material/material.png',
                demos: DemosMaterialAll.materialList.map((e) => e.widget(localizations)).toList(),
                initiallyExpanded: _isMaterialListExpanded.value || isTestModel,
                onTap: (shouldOpenList) {
                  _isMaterialListExpanded.value = shouldOpenList;
                },
              ),
            ),
            _AnimatedCategoryItem(
              startDelayFraction: 0.05,
              controller: _animationController,
              child: CategoryListItem(
                key: const PageStorageKey<GalleryDemoCategory>(
                  GalleryDemoCategory.cupertino,
                ),
                restorationId: 'home_cupertino_category_list',
                category: GalleryDemoCategory.cupertino,
                imageString: 'assets/icons/cupertino/cupertino.png',
                demos: DemosCupertinoAll.cupertinoList.map((e) => e.widget(localizations)).toList(),
                initiallyExpanded: _isCupertinoListExpaned.value || isTestModel,
                onTap: (shouldOpenList) {
                  _isCupertinoListExpaned.value = shouldOpenList;
                },
              ),
            ),
            _AnimatedCategoryItem(
              startDelayFraction: 0.10,
              controller: _animationController,
              child: CategoryListItem(
                key: const PageStorageKey<GalleryDemoCategory>(
                  GalleryDemoCategory.other,
                ),
                restorationId: 'home_other_category_list',
                category: GalleryDemoCategory.other,
                imageString: 'assets/icons/reference/reference.png',
                demos: DemosOthersAll.otherList.map((e) => e.widget(localizations)).toList(),
                initiallyExpanded: _isOtherListExpanded.value || isTestModel,
                onTap: (shouldOpenList) {
                  _isOtherListExpanded.value = shouldOpenList;
                },
              ),
            ),
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
                  itemBuilder: (context, index) => CategoryDemoItem(baseRoute: demos[index].baseRoute,demo: demos[index]),
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
                  category.displayTitle(GalleryLocalizations.of(context)!)!,
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

class _AnimatedCategoryItem extends StatelessWidget {
  _AnimatedCategoryItem({
    required double startDelayFraction,
    required this.controller,
    required this.child,
  }) : topPaddingAnimation = Tween(
          begin: 60.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.000 + startDelayFraction,
              0.400 + startDelayFraction,
              curve: Curves.ease,
            ),
          ),
        );

  final Widget child;
  final AnimationController controller;
  final Animation<double> topPaddingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Padding(
          padding: EdgeInsets.only(top: topPaddingAnimation.value),
          child: child,
        );
      },
      child: child,
    );
  }
}

class _AnimatedCarousel extends StatelessWidget {
  _AnimatedCarousel({
    required this.child,
    required this.controller,
  }) : startPositionAnimation = Tween(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.200,
              0.800,
              curve: Curves.ease,
            ),
          ),
        );

  final Widget child;
  final AnimationController controller;
  final Animation<double> startPositionAnimation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            SizedBox(height: _carouselHeight(.4, context)),
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return PositionedDirectional(
                  start: constraints.maxWidth * startPositionAnimation.value,
                  child: child!,
                );
              },
              child: SizedBox(
                height: _carouselHeight(.4, context),
                width: constraints.maxWidth,
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AnimatedCarouselCard extends StatelessWidget {
  _AnimatedCarouselCard({
    required this.child,
    required this.controller,
  }) : startPaddingAnimation = Tween(
          begin: _horizontalPadding,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.900,
              1.000,
              curve: Curves.ease,
            ),
          ),
        );

  final Widget child;
  final AnimationController controller;
  final Animation<double> startPaddingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Padding(
          padding: EdgeInsetsDirectional.only(
            start: startPaddingAnimation.value,
          ),
          child: child,
        );
      },
    );
  }
}

class _ModbileCarousel extends StatefulWidget {
  const _ModbileCarousel({
    required this.animationController,
    this.restorationId,
    required this.children,
  });

  final AnimationController animationController;
  final String? restorationId;
  final List<Widget> children;

  @override
  State<_ModbileCarousel> createState() => __ModbileCarouselState();
}

class __ModbileCarouselState extends State<_ModbileCarousel> with RestorationMixin, SingleTickerProviderStateMixin {
  late PageController _controller;
  final RestorableInt _currentPage = RestorableInt(0);

  @override
  String? get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_currentPage, 'carousel_page');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final width = MediaQuery.of(context).size.width;
    const padding = (_carouselItemMobileMargin * 2);
    _controller = PageController(
      initialPage: _currentPage.value,
      viewportFraction: (_carouselItemWidth + padding) / width,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _currentPage.dispose();

    super.dispose();
  }

  Widget builder(int idx) {
    final carouselCard = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double value;
        if (_controller.position.haveDimensions) {
          value = _controller.page! - idx;
        } else {
          value = (_currentPage.value - idx).toDouble();
        }
        value = (1 - (value.abs() * .3)).clamp(0, 1).toDouble();
        value = Curves.easeOut.transform(value);

        return Transform.scale(
          scale: value,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: widget.children[idx],
    );

    if (idx == 1) {
      return _AnimatedCarouselCard(
        controller: widget.animationController,
        child: carouselCard,
      );
    } else {
      return carouselCard;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _AnimatedCarousel(
      controller: widget.animationController,
      child: PageView.builder(
        key: const ValueKey('studyDemoList'),
        onPageChanged: (value) {
          setState(() {
            _currentPage.value = value;
          });
        },
        controller: _controller,
        pageSnapping: false,
        itemCount: widget.children.length,
        itemBuilder: (context, index) => builder(index),
        allowImplicitScrolling: true,
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

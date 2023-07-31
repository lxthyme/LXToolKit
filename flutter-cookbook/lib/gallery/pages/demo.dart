// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cookbook/gallery/feature_discovery/feature_discovery.dart';
import 'package:flutter_cookbook/gallery/pages/splash.dart';
import 'package:flutter_cookbook/gallery/themes/material_demo_theme_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:flutter_cookbook/gallery/constants.dart';
import 'package:flutter_cookbook/gallery/data/demos.dart';
import 'package:flutter_cookbook/gallery/data/gallery_options.dart';
import 'package:flutter_cookbook/gallery/layout/adaptive.dart';

enum _DemoState {
  normal,
  options,
  info,
  code,
  fullscreen,
}

class DemoPage extends StatefulWidget {
  const DemoPage({
    super.key,
    required this.slug,
  });

  static const String baseRoute = '/demo';
  final String? slug;

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  late Map<String?, GalleryDemo> slugToDemoMap;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    slugToDemoMap = Demos.asSlugToDemoMap(context);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.slug == null || !slugToDemoMap.containsKey(widget.slug)) {
      Navigator.of(context).pop();
    }
    return ScaffoldMessenger(
      child: GalleryDemoPage(
        restorationId: widget.slug!,
        demo: slugToDemoMap[widget.slug]!,
      ),
    );
  }
}

class GalleryDemoPage extends StatefulWidget {
  const GalleryDemoPage({
    super.key,
    required this.restorationId,
    required this.demo,
  });

  final String restorationId;
  final GalleryDemo demo;

  @override
  State<GalleryDemoPage> createState() => _GalleryDemoPageState();
}

class _GalleryDemoPageState extends State<GalleryDemoPage> with RestorationMixin, TickerProviderStateMixin {
  final RestorableInt _demoStateIndex = RestorableInt(_DemoState.normal.index);
  final RestorableInt _configIndex = RestorableInt(0);

  bool? _isDesktop;

  late AnimationController _codeBackgroundColorController;

  @override
  String get restorationId => widget.restorationId;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_demoStateIndex, 'demo_state');
    registerForRestoration(_configIndex, 'configuration_index');
  }

  GalleryDemoConfiguration get _currentConfig {
    return widget.demo.configurations[_configIndex.value];
  }

  bool get _hasOptions => widget.demo.configurations.length > 1;

  @override
  void initState() {
    super.initState();
    _codeBackgroundColorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _demoStateIndex.dispose();
    _configIndex.dispose();
    _codeBackgroundColorController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isDesktop ??= isDisplayDesktop(context);
  }

  void setStateAndUpdate(VoidCallback callback) {
    setState(() {
      callback();
      if (_demoStateIndex.value == _DemoState.code.index) {
        _codeBackgroundColorController.forward();
      } else {
        _codeBackgroundColorController.reverse();
      }
    });
  }

  void _handleTap(_DemoState newState) {
    var newStateIndex = newState.index;

    if (_demoStateIndex.value == newStateIndex && isDisplayDesktop(context)) {
      if (_demoStateIndex.value == _DemoState.fullscreen.index) {
        setStateAndUpdate(() {
          _demoStateIndex.value = _hasOptions ? _DemoState.options.index : _DemoState.info.index;
        });
      }
      return;
    }

    setStateAndUpdate(() {
      _demoStateIndex.value = _demoStateIndex.value == newStateIndex ? _DemoState.normal.index : newStateIndex;
    });
  }

  Future<void> _showDocumentation(BuildContext context) async {
    final url = _currentConfig.documentationUrl;

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else if (mounted) {
      await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(AppLocalizations.of(context)!.demoInvalidURL),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(url),
              ),
            ],
          );
        },
      );
    }
  }

  void _resolveState(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);
    final isFoldable = isDisplayFoldable(context);
    if (_DemoState.values[_demoStateIndex.value] == _DemoState.fullscreen && !isDesktop) {
      _demoStateIndex.value = _DemoState.normal.index;
    } else if (_DemoState.values[_demoStateIndex.value] == _DemoState.normal && (isDesktop || isFoldable)) {
      _demoStateIndex.value = _hasOptions ? _DemoState.options.index : _DemoState.info.index;
    } else if (isDesktop != _isDesktop) {
      _isDesktop = isDesktop;
      if (!isDesktop) {
        _demoStateIndex.value = _DemoState.normal.index;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFoldable = isDisplayFoldable(context);
    final isDesktop = isDisplayDesktop(context);
    _resolveState(context);

    final colorScheme = Theme.of(context).colorScheme;
    final iconColor = colorScheme.onSurface;
    final selectedIconColor = colorScheme.primary;
    final appBarPadding = isDesktop ? 20.0 : 0.0;
    final currentDemoState = _DemoState.values[_demoStateIndex.value];
    final localizations = AppLocalizations.of(context)!;
    final options = GalleryOptions.of(context);

    final appBar = AppBar(
      systemOverlayStyle: options.resolvedSystemUiOverlayStyle(),
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: EdgeInsetsDirectional.only(start: appBarPadding),
        child: IconButton(
          key: const ValueKey('Back'),
          icon: const BackButtonIcon(),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
      ),
      actions: [
        if (_hasOptions)
          IconButton(
            icon: FeatureDiscovery(
              title: localizations.demoOptionsFeatureTitle,
              description: localizations.demoOptionsFeatureDescription,
              showOverlay: !isDisplayDesktop(context) && !options.isTestMode,
              color: colorScheme.primary,
              onTap: () => _handleTap(_DemoState.options),
              child: Icon(
                Icons.tune,
                color: currentDemoState == _DemoState.options ? selectedIconColor : iconColor,
              ),
            ),
            tooltip: localizations.demoOptionsTooltip,
            onPressed: () => _handleTap(_DemoState.options),
          ),
        IconButton(
          icon: const Icon(Icons.info),
          tooltip: localizations.demoInfoTooltip,
          color: currentDemoState == _DemoState.info ? selectedIconColor : iconColor,
          onPressed: () => _handleTap(_DemoState.info),
        ),
        IconButton(
          icon: const Icon(Icons.code),
          tooltip: localizations.demoCodeTooltip,
          color: currentDemoState == _DemoState.code ? selectedIconColor : iconColor,
          onPressed: () => _handleTap(_DemoState.code),
        ),
        IconButton(
          icon: const Icon(Icons.library_books),
          tooltip: localizations.demoDocumentationTooltip,
          color: iconColor,
          onPressed: () => _showDocumentation(context),
        ),
        if (isDesktop)
          IconButton(
            icon: const Icon(Icons.fullscreen),
            tooltip: localizations.demoFullscreenTooltip,
            color: currentDemoState == _DemoState.fullscreen ? selectedIconColor : iconColor,
            onPressed: () => _handleTap(_DemoState.fullscreen),
          ),
        SizedBox(width: appBarPadding),
      ],
    );

    final mediaQuery = MediaQuery.of(context);
    final bottomSafeArea = mediaQuery.padding.bottom;
    final contentHeight =
        mediaQuery.size.height - mediaQuery.padding.top - mediaQuery.padding.bottom - appBar.preferredSize.height;
    final maxSectionHeight = isDesktop ? contentHeight : contentHeight - 64;
    final horizontalPadding = isDesktop ? mediaQuery.size.width * 0.12 : 0.0;
    const maxSectionWidth = 420.0;

    Widget section;
    switch (currentDemoState) {
      case _DemoState.options:
        section = _DemoSectionOptions(
          maxHeight: maxSectionHeight,
          maxWidth: maxSectionWidth,
          configurations: widget.demo.configurations,
          configIndex: _configIndex.value,
          onConfigChanged: (value) {
            setStateAndUpdate(() {
              _configIndex.value = value;
              if (!isDesktop) {
                _demoStateIndex.value = _DemoState.normal.index;
              }
            });
          },
        );
        break;
      case _DemoState.info:
      // section = _demos
        break;
      case _DemoState.code:
        break;
      default:
        section = const Center(
          child: Text('demo.dart'),
        );
        break;
    }

    Widget body;
    Widget demoContent = ScaffoldMessenger(
      child: DemoWrapper(
        height: contentHeight,
        buildRoute: _currentConfig.buildRoute,
      ),
    );
    if (isDesktop) {
      body = const Center(
        child: Text('demo2.dart: isDesktop'),
      );
    } else if (isFoldable) {
      body = Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: TwoPane(
          startPane: demoContent,
          endPane: section,
        ),
      );
    } else {
      section = AnimatedSize(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.topCenter,
        curve: Curves.easeIn,
        child: section,
      );

      final isDemoNormal = currentDemoState == _DemoState.normal;
      demoContent = Semantics(
        label: '${AppLocalizations.of(context)!.demo}, ${widget.demo.title}',
        child: MouseRegion(
          cursor: isDemoNormal ? MouseCursor.defer : SystemMouseCursors.click,
          child: GestureDetector(
            onTap: isDemoNormal
                ? null
                : () {
                    setStateAndUpdate(() {
                      _demoStateIndex.value = _DemoState.normal.index;
                    });
                  },
            child: Semantics(
              excludeSemantics: !isDemoNormal,
              child: demoContent,
            ),
          ),
        ),
      );

      body = SafeArea(
        bottom: false,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            section,
            demoContent,
            SizedBox(height: bottomSafeArea),
          ],
        ),
      );
    }

    Widget page;
    if (isDesktop || isFoldable) {
      page = const Center(
        child: Text('demo2.dart'),
      );
    } else {
      page = Container(
        color: colorScheme.background,
        child: ApplyTextOptions(
          child: Scaffold(
            appBar: appBar,
            body: body,
            resizeToAvoidBottomInset: false,
          ),
        ),
      );
    }

    if (isDesktop) {
      page = MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: SplashPage(
          child: page,
        ),
      );
    }
    return FeatureDiscoveryController(page);
  }
}

class _DemoSectionOptions extends StatelessWidget {
  const _DemoSectionOptions({
    super.key,
    required this.maxHeight,
    required this.maxWidth,
    required this.configurations,
    required this.configIndex,
    required this.onConfigChanged,
  });

  final double maxHeight;
  final double maxWidth;
  final List<GalleryDemoConfiguration> configurations;
  final int configIndex;
  final ValueChanged<int> onConfigChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Container(
        constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: maxWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 24,
                top: 12,
                end: 24,
              ),
              child: Text(
                AppLocalizations.of(context)!.demoOptionsTooltip,
                style: textTheme.headlineMedium!.apply(
                  color: colorScheme.onSurface,
                  fontSizeDelta: isDisplayDesktop(context) ? desktopDisplay1FontDelta : 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DemoWrapper extends StatelessWidget {
  const DemoWrapper({
    super.key,
    required this.height,
    required this.buildRoute,
  });

  final double height;
  final WidgetBuilder buildRoute;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      height: height,
      child: ClipRRect(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10.0),
          bottom: Radius.circular(2.0),
        ),
        child: Theme(
          data: MaterialDemoThemeData.themeData.copyWith(
            platform: GalleryOptions.of(context).platform,
          ),
          child: CupertinoTheme(
            data: const CupertinoThemeData().copyWith(brightness: Brightness.light),
            child: ApplyTextOptions(
              child: Builder(builder: buildRoute),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_cookbook/gallery/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  String? get restorationId => widget.restorationId;

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
    final isFoldable = isDisplayFoladable(context);
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
    final isDesktop = isDisplayDesktop(context);
    final isFoldable = isDisplayFoladable(context);
    _resolveState(context);

    final colorScheme = Theme.of(context).colorScheme;
    final iconColor = colorScheme.onSurface;
    final selectedIconColor = colorScheme.primary;
    final appbarPadding = isDesktop ? 20.0 : 0.0;
    final currentDemoState = _DemoState.values[_demoStateIndex.value];
    final localizations = AppLocalizations.of(context)!;
    final options = GalleryOptions.of(context);

    final appBar = AppBar(
      systemOverlayStyle: options.resolvedSystemUiOverlayStyle(),
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: EdgeInsetsDirectional.only(start: appbarPadding),
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
        // if(_hasOptions) {
        //   IconButton(
        //     icon: FeatureDisc,
        //   ),
        // }
        IconButton(
          onPressed: () => _handleTap(_DemoState.info),
          icon: const Icon(Icons.info),
          tooltip: localizations.demoInfoTooltip,
          color: currentDemoState == _DemoState.info ? selectedIconColor : iconColor,
        ),
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
    // switch(currentDemoState) {
    //   case _DemoState.options:
    //   section = _DemosSec
    //   break;
    //   case _DemoState.info:
    //   break;
    //   case _DemoState.code:
    //   break;
    //   default: break;
    // }
    return const Center(
      child: Text('demo.dart'),
    );
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

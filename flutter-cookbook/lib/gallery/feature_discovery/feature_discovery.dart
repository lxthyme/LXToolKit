// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_cookbook/gallery/feature_discovery/animation.dart';
import 'package:flutter_cookbook/gallery/feature_discovery/overlay.dart';
import 'package:get_storage/get_storage.dart';

const _featureHighlightShownKey = 'feature_highlight_shown';

class FeatureDiscoveryController extends StatefulWidget {
  const FeatureDiscoveryController(this.child, {super.key});

  final Widget child;

  static _FeatureDiscoveryControllerState _of(BuildContext context) {
    final matchResult = context.findAncestorStateOfType<_FeatureDiscoveryControllerState>();
    if (matchResult != null) {
      return matchResult;
    }

    throw FlutterError(
      'FeatureDiscoveryController.of() called with a context that does not '
      'contain a FeatureDiscoveryController.\n The context used was:\n '
      '$context',
    );
  }

  @override
  State<FeatureDiscoveryController> createState() => _FeatureDiscoveryControllerState();
}

class _FeatureDiscoveryControllerState extends State<FeatureDiscoveryController> {
  bool _isLocked = false;

  bool get isLocked => _isLocked;

  void lock() => _isLocked = true;
  void unlock() => setState(() => _isLocked = false);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    assert(
      context.findAncestorStateOfType<_FeatureDiscoveryControllerState>() == null,
      'There should not be another ancestor of type '
      'FeatureDiscoveryController in the widget tree.',
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class FeatureDiscovery extends StatefulWidget {
  const FeatureDiscovery({
    super.key,
    required this.title,
    required this.description,
    required this.child,
    required this.showOverlay,
    this.onDismiss,
    this.onTap,
    this.color,
  });

  final String title;
  final String description;
  final Icon child;
  final bool showOverlay;
  final void Function()? onDismiss;
  final void Function()? onTap;
  final Color? color;

  @visibleForTesting
  static const overlayKey = Key('overlay key');

  @visibleForTesting
  static const gestureDetectorKey = Key('gesture detector key');

  @override
  State<FeatureDiscovery> createState() => _FeatureDiscoveryState();
}

class _FeatureDiscoveryState extends State<FeatureDiscovery> with TickerProviderStateMixin {
  bool showOverlay = false;
  FeatureDiscoveryStatus status = FeatureDiscoveryStatus.closed;

  late AnimationController openController;
  late AnimationController rippleController;
  late AnimationController tapController;
  late AnimationController dismissController;

  late Animations animations;
  OverlayEntry? overlay;

  void tap() {
    openController.stop();
    rippleController.stop();
    dismissController.stop();
    tapController.forward(from: 0.0);
  }

  void dismiss() {
    openController.stop();
    rippleController.stop();
    tapController.stop();
    dismissController.forward(from: 0.0);
  }

  Widget buildOverlay(BuildContext context, Offset center) {
    debugCheckHasMediaQuery(context);
    debugCheckHasDirectionality(context);

    final deviceSize = MediaQuery.of(context).size;
    final color = widget.color ?? Theme.of(context).colorScheme.primary;

    return Material(
      key: FeatureDiscovery.overlayKey,
      type: MaterialType.transparency,
      child: Stack(
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              key: FeatureDiscovery.gestureDetectorKey,
              onTap: dismiss,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
              ),
            ),
          ),
          Background(
            animations: animations,
            center: center,
            color: color,
            deviceSize: deviceSize,
            status: status,
            textDirection: Directionality.of(context),
          ),
          Content(
            animations: animations,
            center: center,
            description: widget.description,
            deviceSize: deviceSize,
            status: status,
            title: widget.title,
            textTheme: Theme.of(context).textTheme,
          ),
          Ripple(
            animations: animations,
            center: center,
            status: status,
          ),
          TapTarget(
            animations: animations,
            center: center,
            status: status,
            onTap: tap,
            child: widget.child,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (overlay != null) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            overlay!.markNeedsBuild();
          });
        } else {
          if (showOverlay && !FeatureDiscoveryController._of(context).isLocked) {
            final entry = OverlayEntry(
              builder: (_) => buildOverlay(context, getOverlayCenter(context)),
            );

            FeatureDiscoveryController._of(context).lock();

            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              setState(() {
                overlay = entry;
                status = FeatureDiscoveryStatus.closed;
                openController.forward(from: 0.0);
              });
              Overlay.of(context).insert(entry);
            });
          }
        }
        return widget.child;
      },
    );
  }

  Offset getOverlayCenter(BuildContext parentCtx) {
    final box = parentCtx.findRenderObject() as RenderBox;
    final size = box.size;
    final topLeftPosition = box.localToGlobal(Offset.zero);
    final centerPosition = Offset(
      topLeftPosition.dx + size.width / 2,
      topLeftPosition.dy + size.height / 2,
    );
    return centerPosition;
  }

  @override
  void initState() {
    super.initState();

    initAnimationControllers();
    initAnimations();

    final localStorage = GetStorage();
    final featureHiglightShown = localStorage.read<bool>(_featureHighlightShownKey) ?? false;
    localStorage.write(_featureHighlightShownKey, true);
    showOverlay = widget.showOverlay && !featureHiglightShown;
    if (showOverlay) {
      localStorage.write(_featureHighlightShownKey, true);
    }
  }

  void initAnimationControllers() {
    openController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((animationStatus) {
        if (animationStatus == AnimationStatus.forward) {
          setState(() => status = FeatureDiscoveryStatus.open);
        } else if (animationStatus == AnimationStatus.completed) {
          rippleController.forward(from: 0.0);
        }
      });

    rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((animationStatus) {
        if (animationStatus == AnimationStatus.forward) {
          setState(() => status = FeatureDiscoveryStatus.ripple);
        } else if (animationStatus == AnimationStatus.completed) {
          rippleController.forward(from: 0.0);
        }
      });

    tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((animationStatus) {
        if (animationStatus == AnimationStatus.forward) {
          setState(() => status = FeatureDiscoveryStatus.tap);
        } else if (animationStatus == AnimationStatus.completed) {
          widget.onTap?.call();
          cleanUponOverlayClose();
        }
      });

    dismissController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((animationStatus) {
        if (animationStatus == AnimationStatus.forward) {
          setState(() => status = FeatureDiscoveryStatus.dismiss);
        } else if (animationStatus == AnimationStatus.completed) {
          widget.onDismiss?.call();
          cleanUponOverlayClose();
        }
      });
  }

  void initAnimations() {
    animations = Animations(
      openController,
      tapController,
      rippleController,
      dismissController,
    );
  }

  void cleanUponOverlayClose() {
    FeatureDiscoveryController._of(context).unlock();
    setState(() {
      status = FeatureDiscoveryStatus.closed;
      showOverlay = false;
      overlay?.remove();
      overlay = null;
    });
  }

  @override
  void didUpdateWidget(FeatureDiscovery oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showOverlay != oldWidget.showOverlay) {
      showOverlay = widget.showOverlay;
    }
  }

  @override
  void dispose() {
    overlay?.remove();
    openController.dispose();
    rippleController.dispose();
    tapController.dispose();
    dismissController.dispose();

    super.dispose();
  }
}

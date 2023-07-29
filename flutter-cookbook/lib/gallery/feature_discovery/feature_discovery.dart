import 'package:flutter/material.dart';

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

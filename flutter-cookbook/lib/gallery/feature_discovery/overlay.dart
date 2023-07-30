// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_cookbook/gallery/feature_discovery/animation.dart';

const contentHeight = 80.0;
const contentWidth = 300.0;
const contentHorizontalPadding = 40.0;
const tapTargetRadius = 44.0;
const tapTargetToContentDistance = 20.0;
const gutterHeight = 88.0;

class Background extends StatelessWidget {
  const Background({
    super.key,
    required this.animations,
    required this.center,
    required this.color,
    required this.deviceSize,
    required this.status,
    required this.textDirection,
  });

  final Animations animations;
  final Offset center;
  final Color color;
  final Size deviceSize;
  final FeatureDiscoveryStatus status;
  final TextDirection textDirection;

  static const horizontalShift = 20.0;
  static const padding = 40.0;

  Offset get centerPosition {
    if (_isNearTopOrBottomEdges(center, deviceSize)) {
      return center;
    } else {
      final start = center;

      double endY;
      if (_isOnTopHalfOfScreen(center, deviceSize)) {
        endY = center.dy - tapTargetRadius - tapTargetToContentDistance - contentHeight;
        if (endY < 0.0) {
          endY = center.dy + tapTargetRadius + tapTargetToContentDistance;
        }
      } else {
        endY = center.dy + tapTargetRadius + tapTargetToContentDistance;
        if (endY + contentHeight > deviceSize.height) {
          endY = center.dy - tapTargetRadius - tapTargetToContentDistance - contentHeight;
        }
      }

      double shift;
      if (_isOnLeftHalfOfScreen(center, deviceSize)) {
        shift = horizontalShift;
      } else if (center.dx == deviceSize.width / 2) {
        shift = textDirection == TextDirection.ltr ? -horizontalShift : horizontalShift;
      } else {
        shift = -horizontalShift;
      }

      final textBounds = _getContentBounds(deviceSize, center);
      final left = min(textBounds.left, center.dx - 88.0);
      final right = max(textBounds.right, center.dx + 88.0);
      final endX = (left + right) / 2 + shift;
      final end = Offset(endX, endY);

      return animations.backgroundCenter(status, start, end).value;
    }
  }

  double get radius {
    final textBounds = _getContentBounds(deviceSize, center);
    final textRaidus = _maxDistance(center, textBounds) + padding;

    if (_isNearTopOrBottomEdges(center, deviceSize)) {
      return animations.backgroundRadius(status, textRaidus).value;
    } else {
      return animations.backgroundRadius(status, textRaidus).value * 0.8;
    }
  }

  double get opacity => animations.backgroundOpacity(status).value;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: centerPosition.dx,
      top: centerPosition.dy,
      child: FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: radius * 2,
            height: radius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

double _maxDistance(Offset point, Rect bounds) {
  double distance(double x1, double y1, double x2, double y2) {
    return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
  }

  final tl = distance(point.dx, point.dy, bounds.left, bounds.top);
  final tr = distance(point.dx, point.dy, bounds.right, bounds.top);
  final bl = distance(point.dx, point.dy, bounds.left, bounds.bottom);
  final br = distance(point.dx, point.dy, bounds.right, bounds.bottom);
  return max(tl, max(tr, max(bl, br)));
}

class Content extends StatelessWidget {
  const Content({
    super.key,
    required this.animations,
    required this.center,
    required this.description,
    required this.deviceSize,
    required this.status,
    required this.title,
    required this.textTheme,
  });

  final Animations animations;
  final Offset center;
  final String description;
  final Size deviceSize;
  final FeatureDiscoveryStatus status;
  final String title;
  final TextTheme textTheme;

  double get opacity => animations.contentOpacity(status).value;

  @override
  Widget build(BuildContext context) {
    final position = _getContentBounds(deviceSize, center);

    return Positioned(
      top: position.top,
      left: position.left,
      width: position.right - position.left,
      height: position.bottom - position.top,
      child: Opacity(
        opacity: opacity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(textTheme),
            const SizedBox(height: 12.0),
            _buildDescription(textTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(TextTheme theme) {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: theme.titleLarge?.copyWith(color: Colors.white),
    );
  }

  Widget _buildDescription(TextTheme theme) {
    return Text(
      description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: theme.titleMedium?.copyWith(color: Colors.white70),
    );
  }
}

class Ripple extends StatelessWidget {
  const Ripple({
    super.key,
    required this.animations,
    required this.center,
    required this.status,
  });

  final Animations animations;
  final Offset center;
  final FeatureDiscoveryStatus status;

  double get raidus => animations.rippleRadius(status).value;
  double get opacity => animations.rippleOpacity(status).value;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: center.dy,
      left: center.dx,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: raidus * 2,
          height: raidus * 2,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class TapTarget extends StatelessWidget {
  const TapTarget({
    super.key,
    required this.animations,
    required this.center,
    required this.status,
    required this.onTap,
    required this.child,
  });

  final Animations animations;
  final Offset center;
  final FeatureDiscoveryStatus status;
  final void Function() onTap;
  final Icon child;

  double get radius => animations.tapTargetRadius(status).value;
  double get opacity => animations.tapTargetOpacity(status).value;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Positioned(
      top: center.dy,
      left: center.dx,
      child: FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: InkWell(
          onTap: onTap,
          child: Opacity(
            opacity: opacity,
            child: Container(
              width: radius * 2,
              height: radius * 2,
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark ? theme.colorScheme.primary : Colors.white,
                shape: BoxShape.circle,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

Rect _getContentBounds(Size deviceSize, Offset overlayCenter) {
  double top;
  if (_isOnTopHalfOfScreen(overlayCenter, deviceSize)) {
    top = overlayCenter.dy - tapTargetRadius - tapTargetToContentDistance - contentHeight;
    if (top < 0) {
      top = overlayCenter.dy + tapTargetRadius + tapTargetToContentDistance;
    }
  } else {
    top = overlayCenter.dy + tapTargetRadius + tapTargetToContentDistance;
    if (top + contentHeight > deviceSize.height) {
      top = overlayCenter.dy - tapTargetRadius - tapTargetToContentDistance - contentHeight;
    }
  }

  final left = max(contentHorizontalPadding, overlayCenter.dx - contentWidth);
  final right = min(deviceSize.width - contentHorizontalPadding, left + contentWidth);
  return Rect.fromLTRB(left, top, right, top + contentHeight);
}

bool _isNearTopOrBottomEdges(Offset position, Size deviceSize) {
  return position.dy <= gutterHeight || (deviceSize.height - position.dy) <= gutterHeight;
}

bool _isOnTopHalfOfScreen(Offset position, Size deviceSize) {
  return position.dy < (deviceSize.height / 2.0);
}

bool _isOnLeftHalfOfScreen(Offset postion, Size deviceSize) {
  return postion.dx < (deviceSize.width / 2.0);
}

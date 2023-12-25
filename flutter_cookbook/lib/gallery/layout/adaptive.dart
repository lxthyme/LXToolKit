import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/material.dart';

const maxHomeItemWidth = 1400.0;

bool isDisplayDesktop(BuildContext context) =>
    !isDisplayFoldable(context) && getWindowType(context) >= AdaptiveWindowType.medium;

bool isDisplaySmallDesktop(BuildContext context) {
  return getWindowType(context) == AdaptiveWindowType.medium;
}

bool isDisplayFoldable(BuildContext context) {
  final hinge = MediaQuery.of(context).hinge;
  if (hinge == null) {
    return false;
  } else {
    return hinge.bounds.size.aspectRatio < 1;
  }
}

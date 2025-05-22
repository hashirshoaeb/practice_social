import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScrollUpGestureDetector extends StatelessWidget {
  final bool onScrollUpAbsorb;
  final VoidCallback onScrollUp;
  final bool onScrollDownAbsorb;
  final VoidCallback onScrollDown;
  final Widget child;

  const ScrollUpGestureDetector({
    super.key,
    this.onScrollUpAbsorb = false,
    required this.onScrollUp,
    this.onScrollDownAbsorb = false,
    required this.onScrollDown,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        ScrollUpGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<ScrollUpGestureRecognizer>(
              () => ScrollUpGestureRecognizer(),
              (instance) {
                instance
                  ..onScrollUpAbsorb = onScrollUpAbsorb
                  ..onStart = (details) {
                    // print('onStart');
                    onScrollUp();
                  }
                  ..onUpdate = (details) {
                    // print('onUpdate');
                  }
                  ..onEnd = (details) {
                    // print('onEnd');
                  };
              },
            ),
        ScrollDownGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<ScrollDownGestureRecognizer>(
              () => ScrollDownGestureRecognizer(),
              (instance) {
                instance
                  ..onScrollDownAbsorb = onScrollDownAbsorb
                  ..onStart = (details) {
                    // print('onStart');
                    onScrollDown();
                  }
                  ..onUpdate = (details) {
                    // print('onUpdate');
                  }
                  ..onEnd = (details) {
                    // print('onEnd');
                  };
              },
            ),
      },
      child: child,
    );
  }
}

class ScrollUpGestureRecognizer extends VerticalDragGestureRecognizer {
  bool onScrollUpAbsorb = false;
  ScrollUpGestureRecognizer();

  @override
  bool hasSufficientGlobalDistanceToAccept(
    PointerDeviceKind pointerDeviceKind,
    double? deviceTouchSlop,
  ) {
    // If onScrollUpAbsorb is true, reject the gesture
    if (onScrollUpAbsorb) {
      return false;
    }

    // if the user is scrolling down, reject the gesture
    if (globalDistanceMoved > 0) {
      return false;
    }
    return globalDistanceMoved.abs() >
        computeHitSlop(pointerDeviceKind, gestureSettings);
  }

  @override
  String get debugDescription => 'scroll up drag';
}

class ScrollDownGestureRecognizer extends VerticalDragGestureRecognizer {
  bool onScrollDownAbsorb = false;
  ScrollDownGestureRecognizer();

  @override
  bool hasSufficientGlobalDistanceToAccept(
    PointerDeviceKind pointerDeviceKind,
    double? deviceTouchSlop,
  ) {
    // If onScrollDownAbsorb is true, reject the gesture
    if (onScrollDownAbsorb) {
      return false;
    }

    // if the user is scrolling down, reject the gesture
    if (globalDistanceMoved < 0) {
      return false;
    }
    return globalDistanceMoved.abs() >
        computeHitSlop(pointerDeviceKind, gestureSettings);
  }

  @override
  String get debugDescription => 'scroll down drag';
}

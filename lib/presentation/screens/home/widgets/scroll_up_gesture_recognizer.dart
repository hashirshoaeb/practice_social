// class CustomScrollUpGestureRecognizer extends OneSequenceGestureRecognizer {
//   final VoidCallback onScrollUp;
//   final bool Function() absorb;

//   CustomScrollUpGestureRecognizer({
//     required this.onScrollUp,
//     required this.absorb,
//   });

//   Offset? _initialPosition;
//   final double _minScrollDistance =
//       2.0; // Minimum distance to trigger scroll up

//   @override
//   String get debugDescription => 'CustomScrollUpGestureRecognizer';

//   @override
//   void addAllowedPointer(PointerDownEvent event) {
//     super.addAllowedPointer(event);
//     _initialPosition = event.position;
//   }

//   @override
//   void handleEvent(PointerEvent event) {
//     if (event is PointerMoveEvent && _initialPosition != null) {
//       final double dy = _initialPosition!.dy - event.position.dy;
//       print('dy: $dy');
//       // If the movement is downward, reject the gesture
//       if (dy > 0) {
//         resolve(GestureDisposition.rejected);
//       }
//       // Check if the movement is upward and exceeds minimum distance
//       else if (absorb()) {
//         resolve(GestureDisposition.rejected);
//       } else if (dy < 0) {
//         resolve(GestureDisposition.accepted);
//       }
//     }

//     stopTrackingIfPointerNoLongerDown(event);
//   }

//   @override
//   void acceptGesture(int pointer) {
//     onScrollUp();
//     super.acceptGesture(pointer);
//   }

//   @override
//   void didStopTrackingLastPointer(int pointer) {
//     _initialPosition = null;
//   }
// }

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
                    print('onStart');
                    onScrollUp();
                  }
                  ..onUpdate = (details) {
                    print('onUpdate');
                  }
                  ..onEnd = (details) {
                    print('onEnd');
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
                    print('onStart');
                    onScrollDown();
                  }
                  ..onUpdate = (details) {
                    print('onUpdate');
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

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart' hide PageView;

// https://gist.github.com/lukepighetti/dfd337f1f31a1cc15f8b2d105ff73352
class ExtentsPageView extends StatefulWidget {
  ExtentsPageView.extents({
    Key? key,
    this.extents = 1,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PageController? controller,
    required this.physics,
    this.pageSnapping = true,
    required this.onPageChanged,
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    this.dragStartBehavior = DragStartBehavior.start,
  }) : controller = controller ?? PageController(),
       childrenDelegate = SliverChildBuilderDelegate(
         itemBuilder,
         childCount: itemCount,
         addAutomaticKeepAlives: false,
         addRepaintBoundaries: false,
       ),
       super(key: key);

  /// The number of pages to build off screen.
  ///
  /// For example, a value of `1` builds one page ahead and one page behind,
  /// for a total of three built pages.
  ///
  /// This is especially useful for making sure heavyweight widgets have a chance
  /// to load off-screen before the user pulls it into the viewport.
  final int extents;

  /// The axis along which the page view scrolls.
  ///
  /// Defaults to [Axis.horizontal].
  final Axis scrollDirection;

  /// Whether the page view scrolls in the reading direction.
  ///
  /// For example, if the reading direction is left-to-right and
  /// [scrollDirection] is [Axis.horizontal], then the page view scrolls from
  /// left to right when [reverse] is false and from right to left when
  /// [reverse] is true.
  ///
  /// Similarly, if [scrollDirection] is [Axis.vertical], then the page view
  /// scrolls from top to bottom when [reverse] is false and from bottom to top
  /// when [reverse] is true.
  ///
  /// Defaults to false.
  final bool reverse;

  /// An object that can be used to control the position to which this page
  /// view is scrolled.
  final PageController controller;

  /// How the page view should respond to user input.
  ///
  /// For example, determines how the page view continues to animate after the
  /// user stops dragging the page view.
  ///
  /// The physics are modified to snap to page boundaries using
  /// [PageScrollPhysics] prior to being used.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics physics;

  /// Set to false to disable page snapping, useful for custom scroll behavior.
  final bool pageSnapping;

  /// Called whenever the page in the center of the viewport changes.
  final ValueChanged<int> onPageChanged;

  /// A delegate that provides the children for the [PageView].
  ///
  /// The [PageView.custom] constructor lets you specify this delegate
  /// explicitly. The [PageView] and [PageView.builder] constructors create a
  /// [childrenDelegate] that wraps the given [List] and [IndexedWidgetBuilder],
  /// respectively.
  final SliverChildDelegate childrenDelegate;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  @override
  _PageViewState createState() => _PageViewState();
}

class _PageViewState extends State<ExtentsPageView> {
  int _lastReportedPage = 0;

  @override
  void initState() {
    super.initState();
    _lastReportedPage = widget.controller.initialPage;
  }

  AxisDirection _getDirection(BuildContext context) {
    switch (widget.scrollDirection) {
      case Axis.horizontal:
        assert(debugCheckHasDirectionality(context));
        final TextDirection textDirection = Directionality.of(context);
        final AxisDirection axisDirection = textDirectionToAxisDirection(
          textDirection,
        );
        return widget.reverse
            ? flipAxisDirection(axisDirection)
            : axisDirection;
      case Axis.vertical:
        return widget.reverse ? AxisDirection.up : AxisDirection.down;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AxisDirection axisDirection = _getDirection(context);
    final ScrollPhysics physics = widget.physics;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.depth == 0 &&
            widget.onPageChanged != null &&
            notification is ScrollUpdateNotification) {
          final PageMetrics metrics = notification.metrics as PageMetrics;
          final int currentPage = metrics.page?.round() ?? 0;
          if (currentPage != _lastReportedPage) {
            _lastReportedPage = currentPage;
            widget.onPageChanged(currentPage);
          }
        }
        return false;
      },
      child: Scrollable(
        dragStartBehavior: widget.dragStartBehavior,
        axisDirection: axisDirection,
        controller: widget.controller,
        physics: physics,
        viewportBuilder: (BuildContext context, ViewportOffset position) {
          return LayoutBuilder(
            builder: (context, constraints) {
              assert(constraints.hasBoundedHeight);
              assert(constraints.hasBoundedWidth);

              double cacheExtent;

              switch (widget.scrollDirection) {
                case Axis.vertical:
                  cacheExtent = constraints.maxHeight * widget.extents;
                  break;

                case Axis.horizontal:
                default:
                  cacheExtent = constraints.maxWidth * widget.extents;
                  break;
              }

              return Viewport(
                cacheExtent: cacheExtent,
                axisDirection: axisDirection,
                offset: position,
                slivers: <Widget>[
                  SliverFillViewport(
                    viewportFraction: widget.controller.viewportFraction,
                    delegate: widget.childrenDelegate,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(
      EnumProperty<Axis>('scrollDirection', widget.scrollDirection),
    );
    description.add(
      FlagProperty('reverse', value: widget.reverse, ifTrue: 'reversed'),
    );
    description.add(
      DiagnosticsProperty<PageController>(
        'controller',
        widget.controller,
        showName: false,
      ),
    );
    description.add(
      DiagnosticsProperty<ScrollPhysics>(
        'physics',
        widget.physics,
        showName: false,
      ),
    );
    description.add(
      FlagProperty(
        'pageSnapping',
        value: widget.pageSnapping,
        ifFalse: 'snapping disabled',
      ),
    );
  }
}

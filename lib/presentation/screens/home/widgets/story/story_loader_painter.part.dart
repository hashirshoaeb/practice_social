part of 'story.dart';

/// Custom painter for story loading animation
/// Creates a circular loading effect with gradient colors
class StoryLoaderPainter extends CustomPainter {
  /// Current animation value
  final double animation;

  /// Colors for the gradient
  final List<Color> gradientColors;

  /// Size of the gap in the loading animation
  final double gapSize;

  /// Number of dashes in the loading animation
  final int dashes;

  StoryLoaderPainter({
    required this.animation,
    required this.gradientColors,
    required this.gapSize,
    required this.dashes,
  });

  /// Calculates the Y value for the loading animation curve
  double getYValue(double x) {
    if (x < 0 || x > 18) {
      throw ArgumentError('x must be between 0 and 18');
    }

    if (x <= 8) {
      // Ease-in curve from (0, 0) to (8, 5)
      double n = 2.5; // Controls the steepness
      return 5.0 * pow(x / 8.0, n);
    } else {
      // Linear decrease from (8, 5) to (18, 0)
      return ((-5.0 / 10.0) * (x - 8.0)) + 5.0; // slope = -5/10
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double singleAngle = (pi * 2) / dashes;

    final Paint paint =
        Paint()
          ..shader = LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke;

    for (int i = 0; i < dashes; i++) {
      final delayOffest = gapSize - i; // tween - index
      final posistiveOffset = delayOffest > 0 ? delayOffest : 0;
      final remainder = posistiveOffset > 18.0 ? 18.0 : posistiveOffset;

      final gapRemainder = getYValue(remainder.toDouble()) * pi / 180;
      canvas.drawArc(
        Offset.zero & size,
        gapRemainder + singleAngle * i,
        singleAngle - gapRemainder * 2,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(StoryLoaderPainter oldDelegate) =>
      oldDelegate.animation != animation;
}

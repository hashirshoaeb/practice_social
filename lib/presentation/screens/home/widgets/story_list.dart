import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum StoryType { create, live, regular }

class StoryList extends StatelessWidget {
  StoryList({super.key});

  final List<({String name, String imageUrl, StoryType storyType})> stories = [
    (
      name: 'Create',
      imageUrl:
          'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?q=80&w=200',
      storyType: StoryType.create,
    ),
    (
      name: 'Michelle_w...',
      imageUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=200',
      storyType: StoryType.live,
    ),
    (
      name: 'frankoo',
      imageUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=200',
      storyType: StoryType.regular,
    ),
    (
      name: 'its_doggo',
      imageUrl:
          'https://images.unsplash.com/photo-1552053831-71594a27632d?q=80&w=200',
      storyType: StoryType.regular,
    ),
    (
      name: 'catmom',
      imageUrl:
          'https://images.unsplash.com/photo-1618826411640-d6df44dd3f7a?q=80&w=200',
      storyType: StoryType.regular,
    ),
    (
      name: 'travel_guy',
      imageUrl:
          'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=200',
      storyType: StoryType.regular,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: const EdgeInsets.only(top: 8.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return _StoryItem(
            name: stories[index].name,
            imageUrl: stories[index].imageUrl,
            storyType: stories[index].storyType,
          );
        },
      ),
    );
  }
}

class _StoryItem extends StatefulWidget {
  final String name;
  final String imageUrl;
  final StoryType storyType;

  const _StoryItem({
    required this.name,
    required this.imageUrl,
    required this.storyType,
  });

  @override
  State<_StoryItem> createState() => _StoryItemState();
}

class _StoryItemState extends State<_StoryItem>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  late AnimationController _animationController;
  late Animation<double> base;
  late Animation<double> reverse;
  late Animation<double> gap;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    base = CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    gap = Tween<double>(begin: 0, end: 18 * 2).animate(base);
    reverse = Tween<double>(begin: 0, end: -0.15).animate(base);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        _animationController.repeat();
        await Future.delayed(const Duration(seconds: 5));
        _animationController.stop();
        _animationController.reset();
        setState(() {
          isLoading = false;
        });
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Story border or loading animation
                _buildLoadingAnimation(70),
                // Profile image
                Container(
                  width: 66,
                  height: 66,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: switch (widget.storyType) {
                      StoryType.create => const Color(0xFFFF8D00),
                      _ => null,
                    },
                    border: Border.all(color: Colors.black, width: 2),
                    image: switch (widget.storyType) {
                      StoryType.create => null,
                      _ => DecorationImage(
                        image: NetworkImage(widget.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    },
                  ),
                ),

                // Add button for create story
                if (widget.storyType == StoryType.create)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00E5FF),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/add.svg',
                          width: 12,
                          height: 12,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),

                // Live badge
                if (widget.storyType == StoryType.live)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF0050),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'LIVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.name,
              style: const TextStyle(color: Colors.white, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingAnimation(double size) {
    List<Color> gradientColors =
        widget.storyType == StoryType.live
            ? const [Color(0xFFFF0050), Color(0xFF7700FF)]
            : const [Color(0xFF00C2FF), Color(0xFF00E5FF)];

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SizedBox(
          width: size,
          height: size,
          child: RotationTransition(
            turns: reverse,
            child: CustomPaint(
              painter: StoryLoaderPainter(
                animation: _animationController.value,
                gradientColors: gradientColors,
                gapSize: gap.value,
                dashes: 18,
              ),
            ),
          ),
        );
      },
    );
  }
}

class StoryLoaderPainter extends CustomPainter {
  final double animation;
  final List<Color> gradientColors;
  final double gapSize;
  final int dashes;
  StoryLoaderPainter({
    required this.animation,
    required this.gradientColors,
    required this.gapSize,
    required this.dashes,
  });

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
    // final double gap = pi / 180 * gapSize;
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

// class _MyPageState extends State<HomeScreen>
//     with SingleTickerProviderStateMixin {
//   late Animation<double> gap;
//   late Animation<double> base;
//   late Animation<double> reverse;
//   late AnimationController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 4),
//     );
//     base = CurvedAnimation(parent: controller, curve: Curves.easeOut);
//     reverse = Tween<double>(begin: 0.0, end: -1.0).animate(base);
//     gap = Tween<double>(begin: 3.0, end: 0.0).animate(base)..addListener(() {
//       setState(() {});
//     });
//     controller.forward();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         alignment: Alignment.center,
//         child: RotationTransition(
//           turns: base,
//           child: DashedCircle(
//             gapSize: gap.value,
//             dashes: 40,
//             color: Color(0XFFED4634),
//             child: RotationTransition(
//               turns: reverse,
//               child: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: CircleAvatar(
//                   radius: 80.0,
//                   backgroundImage: NetworkImage(
//                     "https://images.unsplash.com/photo-1564564295391-7f24f26f568b",
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

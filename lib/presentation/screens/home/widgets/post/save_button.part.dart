part of 'post.dart';

/// Animated save button with Lottie animation
class SaveButton extends StatefulWidget {
  const SaveButton({super.key});

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> with TickerProviderStateMixin {
  /// Controller for Lottie animation
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_animationController.status == AnimationStatus.completed) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
        // Haptic feedback
        HapticFeedback.lightImpact();
      },
      child: Column(
        children: [
          LottieBuilder.asset(
            'assets/save.json',
            height: 60,
            width: 60,
            controller: _animationController,
            animate: false,
            reverse: false,
            repeat: false,
          ),
          const SizedBox(height: 8),
          Text(
            "34k",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

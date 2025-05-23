part of 'post.dart';

/// Interactive button for post actions
/// Displays icon and count with tap functionality
class InteractionButton extends StatelessWidget {
  /// Icon asset path
  final String icon;

  /// Text to display
  final String text;

  /// Callback for tap events
  final VoidCallback onTap;

  const InteractionButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          icon,
          height: 30,
          width: 30,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

/// Main For You tab widget
/// Currently displays a placeholder feed with colored containers
class ForYouTab extends StatefulWidget {
  const ForYouTab({super.key});
  @override
  State<ForYouTab> createState() => _ForYouTabState();
}

class _ForYouTabState extends State<ForYouTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        // Placeholder content with alternating colors
        final color = Colors.primaries[index % Colors.primaries.length];
        return SafeArea(child: Container(color: color));
      },
    );
  }
}

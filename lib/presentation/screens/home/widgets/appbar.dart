import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A transparent app bar with tab navigation and action buttons
/// Used in the home screen for switching between Following and For You content
class TransparentAppBar extends StatelessWidget {
  /// Controller for managing tab navigation
  final TabController tabController;

  const TransparentAppBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Live button
              _AppBarIcon(assetPath: 'assets/live.svg'),
              // Tab navigation
              SizedBox(
                width: 200,
                child: TabBar(
                  controller: tabController,
                  labelColor: Colors.white,
                  padding: EdgeInsets.zero,
                  indicatorColor: Colors.white,
                  indicatorWeight: 2.0,
                  indicatorPadding: EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 0,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: EdgeInsets.zero,
                  dividerHeight: 0,
                  unselectedLabelColor: Colors.white.withAlpha(
                    (0.5 * 255).toInt(),
                  ),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                  tabs: [
                    _AppBarTab(text: 'Following'),
                    _AppBarTab(text: 'For You'),
                  ],
                ),
              ),
              // Search button
              _AppBarIcon(assetPath: 'assets/search.svg'),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom tab widget for the app bar
/// Provides consistent styling for tab items
class _AppBarTab extends StatelessWidget {
  /// Text to display in the tab
  final String text;

  const _AppBarTab({required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 200, height: 25, child: Center(child: Text(text)));
  }
}

/// Custom icon widget for the app bar
/// Handles SVG icons with tap functionality
class _AppBarIcon extends StatelessWidget {
  /// Path to the SVG asset
  final String assetPath;

  /// Optional callback for tap events
  final VoidCallback? onTap;

  const _AppBarIcon({required this.assetPath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(assetPath, height: 28, width: 28),
    );
  }
}

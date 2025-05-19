import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransparentAppBar extends StatelessWidget {
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
              _AppBarIcon(assetPath: 'assets/live.svg'),
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
                  // dividerColor: Colors.transparent,
                  dividerHeight: 0,
                  unselectedLabelColor: Colors.white.withOpacity(0.5),
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
              _AppBarIcon(assetPath: 'assets/search.svg'),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBarTab extends StatelessWidget {
  final String text;

  const _AppBarTab({required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 200, height: 25, child: Center(child: Text(text)));
  }
}

class _AppBarIcon extends StatelessWidget {
  final String assetPath;
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

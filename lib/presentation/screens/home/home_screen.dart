import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:practice_social/presentation/screens/home/widgets/bottom_navbar.dart';
import 'widgets/appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  // @override
  // bool get wantKeepAlive => true;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              // Following Tab Content
              FollowingTab(),
              // For You Tab Content
              ForYouTab(),
            ],
          ),
          TransparentAppBar(tabController: _tabController),
        ],
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}

class FollowingTab extends StatefulWidget {
  @override
  State<FollowingTab> createState() => _FollowingTabState();
}

class _FollowingTabState extends State<FollowingTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        final color = Colors.primaries[index % Colors.primaries.length];
        return SafeArea(child: Container(color: color));
      },
    );
  }
}

class ForYouTab extends StatefulWidget {
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
        final color = Colors.primaries[index % Colors.primaries.length];
        return SafeArea(child: Container(color: color));
      },
    );
  }
}

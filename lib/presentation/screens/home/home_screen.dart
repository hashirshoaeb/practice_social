import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_social/domain/repository/post_repository.dart';
import 'package:practice_social/presentation/cubit/following_tab_control_cubit/following_tab_control_cubit.dart';
import 'package:practice_social/presentation/cubit/post_cubit/post_cubit.dart';
import 'package:practice_social/presentation/screens/home/widgets/bottom_navbar/bottom_navbar.dart';
import 'package:practice_social/presentation/screens/home/widgets/following_tab/following_tab.dart';
import 'package:practice_social/presentation/screens/home/widgets/for_you_tab.dart';
import 'widgets/appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              // Following Tab Content
              MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => FollowingTabControlCubit()),
                  BlocProvider(
                    create:
                        (context) =>
                            PostCubit(postRepository: PostRepository()),
                  ),
                ],
                child: FollowingTab(),
              ),
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

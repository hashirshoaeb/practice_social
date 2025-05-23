import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

part 'add_button.part.dart';
part 'nav_item.part.dart';

/// Main bottom navigation bar widget
/// Displays navigation items with animations and notifications
class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  /// Current selected navigation index
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(
          top: BorderSide(color: Colors.grey.shade900, width: 0.5),
        ),
      ),
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Navigation items
            _NavItem(
              icon: 'assets/home.svg',
              label: 'Home',
              isSelected: _currentIndex == 0,
              onTap: () => setState(() => _currentIndex = 0),
            ),
            _NavItem(
              icon: 'assets/friends.svg',
              label: 'Friends',
              isSelected: _currentIndex == 1,
              onTap: () => setState(() => _currentIndex = 1),
            ),
            _AddButton(),
            _NavItem(
              icon: 'assets/inbox.svg',
              label: 'Inbox',
              isSelected: _currentIndex == 3,
              hasNotification: true,
              notificationCount: '12',
              onTap: () => setState(() => _currentIndex = 3),
            ),
            _NavItem(
              icon: 'assets/profile.svg',
              label: 'Profile',
              isSelected: _currentIndex == 4,
              onTap: () => setState(() => _currentIndex = 4),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

/// Individual navigation item with animation and notification support
class _NavItem extends StatefulWidget {
  /// Icon asset path
  final String icon;

  /// Label text
  final String label;

  /// Whether this item is currently selected
  final bool isSelected;

  /// Whether to show notification badge
  final bool hasNotification;

  /// Notification count text
  final String? notificationCount;

  /// Callback for tap events
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSelected = false,
    this.hasNotification = false,
    this.notificationCount,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem>
    with SingleTickerProviderStateMixin {
  /// Controller for scale animation
  late AnimationController _animationController;

  /// Animation for scale effect
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) {
        _animationController.reverse();
        widget.onTap();
      },
      onTapCancel: () => _animationController.reverse(),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              );
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Icon
                SvgPicture.asset(
                  widget.icon,
                  height: 28,
                  width: 28,
                  colorFilter: ColorFilter.mode(
                    widget.isSelected ? Colors.white : const Color(0xFFBFBFBF),
                    BlendMode.srcIn,
                  ),
                ),
                // Notification badge
                if (widget.hasNotification && widget.notificationCount != null)
                  Positioned(
                    right: -10,
                    top: -8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        widget.notificationCount!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          // Label
          Text(
            widget.label,
            style: TextStyle(
              color: widget.isSelected ? Colors.white : const Color(0xFFBFBFBF),
              fontSize: 12,
              fontFamily: 'Proxima Nova',
            ),
          ),
        ],
      ),
    );
  }
}

/// Special add button with gradient background
class _AddButton extends StatefulWidget {
  @override
  State<_AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<_AddButton>
    with SingleTickerProviderStateMixin {
  /// Controller for scale animation
  late AnimationController _animationController;

  /// Animation for scale effect
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) => _animationController.reverse(),
      onTapCancel: () => _animationController.reverse(),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              );
            },
            child: Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF00C2FF), Color(0xFFFF00D6)],
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/add_story.svg',
                  height: 10,
                  width: 10,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
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

class _NavItem extends StatefulWidget {
  final String icon;
  final String label;
  final bool isSelected;
  final bool hasNotification;
  final String? notificationCount;
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
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  // bool _isPressed = false;

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
      onTapDown: (_) {
        _animationController.forward();
        // setState(() => _isPressed = true);
      },
      onTapUp: (_) {
        _animationController.reverse();
        // setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () {
        _animationController.reverse();
        // setState(() => _isPressed = false);
      },
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
                SvgPicture.asset(
                  widget.icon,
                  height: 28,
                  width: 28,
                  colorFilter: ColorFilter.mode(
                    widget.isSelected ? Colors.white : const Color(0xFFBFBFBF),
                    BlendMode.srcIn,
                  ),
                ),
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

class _AddButton extends StatefulWidget {
  @override
  State<_AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<_AddButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  // bool _isPressed = false;

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
      onTapDown: (_) {
        _animationController.forward();
        // setState(() => _isPressed = true);
      },
      onTapUp: (_) {
        _animationController.reverse();
        // setState(() => _isPressed = false);
      },
      onTapCancel: () {
        _animationController.reverse();
        // setState(() => _isPressed = false);
      },
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

// lib/widgets/app_bottom_nav.dart
import 'package:flutter/material.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';
import 'package:project_iti_2025/presentation/screens/signup/signup_screen.dart';

class AppBottomNav extends StatelessWidget {
  final void Function(int)? onTap;
  final int currentIndex;

  const AppBottomNav({super.key, this.onTap, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 192, 110, 77),
      selectedItemColor: AppColors.white,
     unselectedItemColor: AppColors.white.withValues(alpha: 0.8),

      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
      ],
      onTap: onTap ??
          (index) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const SignUpScreen()),
            );
          },
    );
  }
}

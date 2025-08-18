import 'package:flutter/material.dart';
import 'package:project_iti_2025/presentation/screens/cart/cart_screen.dart';
import 'package:project_iti_2025/presentation/screens/profile/profile_screen.dart';
import 'package:project_iti_2025/presentation/widgets/auth/app_bottom_nav.dart';
import 'package:project_iti_2025/presentation/screens/home/home_screen_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreenContent(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),

            bottomNavigationBar: const AppBottomNav(currentIndex: 0),

    );
  }
}
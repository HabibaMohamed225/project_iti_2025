
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/home/menu_bloc.dart';
import 'package:project_iti_2025/blocs/profile/profile_bloc.dart';
import 'package:project_iti_2025/blocs/cart/cart_bloc.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';
import 'package:project_iti_2025/presentation/screens/home/home_screen.dart';
import 'package:project_iti_2025/presentation/screens/profile/profile_screen.dart';
import 'package:project_iti_2025/presentation/screens/cart/cart_screen.dart';

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
            if (index == 0) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => MenuBloc()..add(FetchMenuEvent()),
                    child: const HomeScreen(),
                  ),
                ),
              );
            } else if (index == 1) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => ProfileBloc(),
                    child: const ProfileScreen(),
                  ),
                ),
              );
            } else if (index == 2) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => CartBloc(),
                    child: const CartScreen(),
                  ),
                ),
              );
            }
          },
    );
  }
}
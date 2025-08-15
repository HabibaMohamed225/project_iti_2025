import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/delivery/delivery_bloc.dart';
import 'package:project_iti_2025/presentation/screens/delivery/delivery_screen_content.dart';
import 'package:project_iti_2025/presentation/widgets/auth/app_bottom_nav.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';

class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DeliveryBloc(),
      child: Scaffold(
        backgroundColor: AppColors.pageBackground,
        appBar: AppBar(
          title: const Text('Delivery Address'),
          backgroundColor: AppColors.white,
          elevation: 0,
        ),
        body: const DeliveryScreenContent(),
        bottomNavigationBar: const AppBottomNav(),
      ),
    );
  }
}

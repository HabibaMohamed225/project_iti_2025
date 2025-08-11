import 'package:flutter/material.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';
import 'package:project_iti_2025/core/constants/app_strings.dart';
import 'package:project_iti_2025/presentation/screens/login/login_screen_conent.dart';
import 'package:project_iti_2025/presentation/widgets/auth/auth_header.dart';
import 'package:project_iti_2025/presentation/widgets/shared_card.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AuthHeader(
              title: AppStrings.welcomeBack,
              subtitle: AppStrings.signInToYourAccount,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: SharedCard(
                child: LoginScreenContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

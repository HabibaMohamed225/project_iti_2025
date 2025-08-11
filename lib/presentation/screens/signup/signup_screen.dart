import 'package:flutter/material.dart';
import 'package:project_iti_2025/presentation/screens/signup/SignUpScreen_Content.dart';
import 'package:project_iti_2025/presentation/widgets/shared_card.dart';
import 'package:project_iti_2025/presentation/widgets/auth/auth_header.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';
import 'package:project_iti_2025/core/constants/app_strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AuthHeader(
              title: AppStrings.createAccount,
              subtitle: AppStrings.joinOurCommunity,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: SharedCard(child: SignUpScreenContent()),
            ),
          ],
        ),
      ),
    );
  }
}

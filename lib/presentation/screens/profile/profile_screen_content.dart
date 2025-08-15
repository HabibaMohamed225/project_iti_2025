import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/profile/profile_bloc.dart';
import 'package:project_iti_2025/blocs/profile/profile_event.dart';
import 'package:project_iti_2025/blocs/profile/profile_state.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';
import 'package:project_iti_2025/core/constants/app_strings.dart';

class ProfileScreenContent extends StatelessWidget {
  final ProfileLoaded state;

  const ProfileScreenContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final displayName = state.displayName ?? AppStrings.noUsername;
    final email = state.email ?? AppStrings.noEmail;
    const maskedPassword = AppStrings.maskedPassword;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.containerBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.containerBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              AppStrings.personalInformation,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            const Text(
              AppStrings.yourAccountDetails,
              style: TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings.username,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 6),
            Align(alignment: Alignment.centerLeft, child: Text(displayName)),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings.email,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 6),
            Align(alignment: Alignment.centerLeft, child: Text(email)),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppStrings.password,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 6),
            const Align(
                alignment: Alignment.centerLeft, child: Text(maskedPassword)),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    AppStrings.deleteAccountInstruction,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<ProfileBloc>().add(LogoutRequested());
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: const Color.fromARGB(255, 192, 110, 77),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  child: const Text(AppStrings.logout),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

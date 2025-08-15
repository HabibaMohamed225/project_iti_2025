import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/login/login_bloc.dart';
import 'package:project_iti_2025/blocs/profile/profile_bloc.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';
import 'package:project_iti_2025/core/constants/app_strings.dart';
import 'package:project_iti_2025/presentation/screens/admin/admin_page_screan.dart';
import 'package:project_iti_2025/presentation/screens/profile/profile_screen.dart';
import 'package:project_iti_2025/presentation/screens/signup/signup_screen.dart';
import 'package:project_iti_2025/presentation/widgets/custom_text_field.dart';
import 'package:project_iti_2025/presentation/widgets/primary_botton.dart';

class LoginScreenContent extends StatefulWidget {
  const LoginScreenContent({super.key});

  @override
  State<LoginScreenContent> createState() => _LoginScreenContentState();
}

class _LoginScreenContentState extends State<LoginScreenContent> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword1 = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFaildState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.msg), backgroundColor: Colors.red),
          );
        }

        if (state is LoginRedirectToAdminState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AdminProductsPage()),
          );
          return;
        }

        if (state is LoginSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => ProfileBloc(),
                child: const ProfileScreen(),
              ),
            ),
          );
        }
      },
      child: Column(
        children: [
          Text(
            AppStrings.signIn,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.email,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            controller: emailController,
            hintText: AppStrings.enterYourEmail,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.pleaseEnterYourEmail;
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.password,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            controller: passwordController,
            hintText: AppStrings.enterYourPassword,
            prefixIcon: Icons.lock_outline,
            suffixIcon: _obscurePassword1
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            obscureText: _obscurePassword1,
            onSuffixIconPressed: () {
              setState(() {
                _obscurePassword1 = !_obscurePassword1;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.pleaseEnterYourPassword;
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          PrimaryButton(
            text: AppStrings.signIn,
            onPressed: () {
              context.read<LoginBloc>().add(
                    LoginButttonPressedEvent(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    ),
                  );
            },
          ),
          const SizedBox(height: 20),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: AppColors.primaryButtonColor,
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
              child: RichText(
                text: TextSpan(
                  text: AppStrings.donHaveAnAccount,
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: ' ${AppStrings.signUp}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.primaryButtonColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

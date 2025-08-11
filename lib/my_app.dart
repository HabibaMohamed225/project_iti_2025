import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/admin/admin_bloc.dart';
import 'package:project_iti_2025/blocs/login/login_bloc.dart';
import 'package:project_iti_2025/blocs/profile/profile_bloc.dart';
import 'package:project_iti_2025/data/repositories/product_repo.dart';
import 'package:project_iti_2025/presentation/screens/admin/admin_page_screan.dart';
import 'package:project_iti_2025/presentation/screens/login/login_screen.dart';
import 'package:project_iti_2025/presentation/screens/profile/profile_screen.dart';
import 'package:project_iti_2025/presentation/screens/signup/signup_screen.dart';
import 'package:project_iti_2025/core/themes/app_themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(
          create: (_) => ProductBloc(ProductRepo())..add(LoadProductsEvent()),
        ),
      ],
      child: MaterialApp(
        theme: AppThemes.lightTheme,
        home: const LoginScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/signup': (ctx) => const SignUpScreen(),
          '/profile': (ctx) => const ProfileScreen(),
          '/admin': (ctx) => const AdminProductsPage(),
        },
      ),
    );
  }
}

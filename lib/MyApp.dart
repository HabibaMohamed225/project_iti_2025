import 'package:flutter/material.dart';
//import 'package:iti_project/features/auth/bloc/login/bloc/login_bloc.dart';
//import 'package:iti_project/features/auth/bloc/profile/profile_bloc.dart';
//import 'package:iti_project/features/auth/bloc/login/screans/login_screen.dart';
import 'package:project_iti_2025/presentation/screens/signup/signup_screen.dart';
//import 'package:iti_project/features/auth/bloc/profile/screens/profile_screen.dart';
import 'package:project_iti_2025/core/themes/app_themes.dart';

/*class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //BlocProvider(create: (context) => LoginBloc()),
        //BlocProvider(create: (context) => ProfileBloc()),
      ],
      child: MaterialApp(
        theme: AppThemes.lightTheme,
        //home: const LoginScreen(),
        home: const SignUpScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/signup': (ctx) => const SignUpScreen(),
          //'/profile': (ctx) => const ProfileScreen(),
        },
      ),
    );
  }
}*/
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.lightTheme,
      home: const SignUpScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/signup': (ctx) => const SignUpScreen(),
      },
    );
  }
}

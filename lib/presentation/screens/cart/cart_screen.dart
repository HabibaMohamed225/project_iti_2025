import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/cart/cart_bloc.dart';
import 'package:project_iti_2025/blocs/cart/cart_state.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';
import 'package:project_iti_2025/core/constants/app_strings.dart';
import 'package:project_iti_2025/presentation/widgets/auth/app_bottom_nav.dart';
import 'cart_screen_content.dart';
class CartScreen extends StatelessWidget {
const CartScreen({super.key});
@override
Widget build(BuildContext context) {
final theme = Theme.of(context).textTheme;
return Scaffold( 
  appBar: AppBar(
     title: BlocBuilder<CartBloc, CartState>
     ( builder: (context, state) 
     { return Column(
       crossAxisAlignment:
        CrossAxisAlignment.start,
         children: [
           Text( AppStrings.yourCart,
            style: theme.titleLarge?.copyWith( color: AppColors.primaryTextColor,
             fontWeight: FontWeight.bold, ), ),
              Text( "Items: ${state.itemCount}",
               style: theme.bodySmall?.copyWith(color: AppColors.darkGrey),
                ),
                 ],
                  );
                   },
                    ),
                     ),
                      body: const CartScreenContent(),
                       bottomNavigationBar: const AppBottomNav(currentIndex: 1), ); 
}
}
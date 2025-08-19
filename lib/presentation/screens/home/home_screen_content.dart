import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/home/menu_bloc.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';
import 'package:project_iti_2025/core/constants/app_strings.dart';
import 'package:project_iti_2025/blocs/cart/cart_bloc.dart';
import 'package:project_iti_2025/blocs/cart/cart_event.dart';
import 'package:project_iti_2025/data/models/cart_item.dart';
import 'package:project_iti_2025/presentation/widgets/custom_text_field.dart';
import 'package:project_iti_2025/presentation/widgets/shared_card.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  String searchQuery = "";
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() {
      setState(() {
        searchQuery = _searchCtrl.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/logo.jpg',
                width: 60,
                height: 60,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Center(
                  child: Text(
                    AppStrings.welcomeMessage,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brownButtonColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),

          const SizedBox(height: 12),
          CustomTextFormField(
            controller: _searchCtrl,
            hintText: AppStrings.searchMenuItems,
            labelText: AppStrings.searchMenuItems,
            prefixIcon: Icons.search,
          ),

          const SizedBox(height: 16),

          Expanded(
            child: BlocBuilder<MenuBloc, MenuState>(
              builder: (context, state) {
                if (state is MenuLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is MenuError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: AppColors.red),
                    ),
                  );
                }

                if (state is MenuLoaded) {
                  final filteredItems = state.menuItems.where((item) {
                    final matchesSearch = item['name']
                        .toString()
                        .toLowerCase()
                        .contains(searchQuery);
                    return matchesSearch;
                  }).toList();

                  if (filteredItems.isEmpty) {
                    return const Center(
                      child: Text(AppStrings.noProductsFound),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.only(bottom: 60),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 11,
                      mainAxisSpacing: 11,
                    ),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];

                      return SharedCard(
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                image: item['imageUrl'] != null &&
                                        item['imageUrl'].toString().isNotEmpty
                                    ? DecorationImage(
                                        image:
                                            NetworkImage(item['imageUrl'] ?? ''),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                                color: AppColors.mediumGrey,
                              ),
                              alignment: Alignment.center,
                              child: (item['imageUrl'] == null ||
                                      item['imageUrl'].toString().isEmpty)
                                  ? const Icon(Icons.image_not_supported)
                                  : null,
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name'] ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item['description'] ?? '',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.darkGrey,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          "\$${item['price']}",
                                          style: const TextStyle(
                                            color: AppColors.primaryButtonColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    icon: const Icon(
                                      Icons.add_circle,
                                      color: AppColors.primaryButtonColor,
                                      size: 22,
                                    ),
                                    onPressed: () {
                                      
                                      final productId = item['id']?.toString();
                                      if (productId == null || productId.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Error: The product has no identifier (ID)!'),
                                          ),
                                        );
                                        return;
                                      }

                                      final cartItem = CartItem(
                                        id: productId,
                                        name: (item['name'] ?? 'Product without name')
                                            .toString(),
                                        price: double.tryParse(
                                                item['price']?.toString() ??
                                                    '0') ??
                                            0.0,
                                        quantity: 1,
                                        imageUrl: item['imageUrl']?.toString(),
                                        description:
                                            item['description']?.toString(),
                                      );

                                      context
                                          .read<CartBloc>()
                                          .add(AddToCart(cartItem));

                                      ScaffoldMessenger.of(context)
                                          .removeCurrentSnackBar();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            '${cartItem.name} ${AppStrings.productAdded}',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
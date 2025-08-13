import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/home/menu_bloc.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';

// Cart imports
import 'package:project_iti_2025/blocs/cart/cart_bloc.dart';
import 'package:project_iti_2025/blocs/cart/cart_event.dart';
import 'package:project_iti_2025/data/models/cart_item.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  String searchQuery = "";
  final Set<String> favoriteItems = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // اللوجو واسم المطعم
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
                    'Welcome to Relax restaurant',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(181, 141, 74, 11),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),

          const SizedBox(height: 12),

          TextField(
            decoration: InputDecoration(
              hintText: "Search...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: AppColors.inputBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value.toLowerCase();
              });
            },
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
                      style: const TextStyle(color: Colors.red),
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
                    return const Center(child: Text("No items found"));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.only(bottom: 60),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 11,
                      mainAxisSpacing: 11,
                    ),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      final isFavorite = favoriteItems.contains(item['name']);

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // صورة المنتج
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.network(
                                item['imageUrl'],
                                height: 140,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  height: 140,
                                  color: Colors.grey[200],
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.image_not_supported),
                                ),
                              ),
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
                                          item['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item['description'] ?? '',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[700],
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      // زر المفضلة
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        icon: Icon(
                                          isFavorite
                                              ? Icons.star
                                              : Icons.star_border,
                                        ),
                                        color: AppColors.primaryButtonColor,
                                        iconSize: 20,
                                        onPressed: () {
                                          setState(() {
                                            if (isFavorite) {
                                              favoriteItems.remove(item['name']);
                                            } else {
                                              favoriteItems.add(item['name']);
                                            }
                                          });
                                        },
                                      ),
                                      // زر الإضافة للكارت
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        icon: const Icon(Icons.add_circle,
                                            color: AppColors.primaryButtonColor,
                                            size: 22),
                                        onPressed: () {
                                          final cartItem = CartItem(
                                            id: (item['id'] ?? item['name'])
                                                .toString(),
                                            name:
                                                (item['name'] ?? '').toString(),
                                            price: double.tryParse(item['price']
                                                        ?.toString() ??
                                                    '0') ??
                                                0.0,
                                            quantity: 1,
                                            imageUrl:
                                                item['imageUrl']?.toString(),
                                            description: item['description']
                                                ?.toString(),
                                          );

                                          context
                                              .read<CartBloc>()
                                              .add(AddToCart(cartItem));

                                          ScaffoldMessenger.of(context)
                                              .removeCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    '${item['name']} added to cart')),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                "\$${item['price']}",
                                style: const TextStyle(
                                  color: AppColors.primaryButtonColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
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
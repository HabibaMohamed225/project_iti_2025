import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/admin/admin_bloc.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';
import 'package:project_iti_2025/core/constants/app_strings.dart';
import 'package:project_iti_2025/presentation/screens/admin/admin_add_screan.dart';
import 'package:project_iti_2025/presentation/widgets/admin_widge/build_product_card.dart';
import 'package:project_iti_2025/presentation/widgets/admin_widge/stat_card.dart';

class AdminProductsScreenContent extends StatelessWidget {
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;

  const AdminProductsScreenContent({
    super.key,
    required this.searchQuery,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final productBloc = context.read<ProductBloc>();
    final navigator = Navigator.of(context);

    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductSuccessState) {
          productBloc.add(LoadProductsEvent());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message, style: theme.textTheme.bodyMedium),
            ),
          );
        } else if (state is ProductErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
          );
        }
      },
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoadedState) {
            final products = state.products
                .where(
                  (p) => p.name.toLowerCase().contains(
                        searchQuery.toLowerCase(),
                      ),
                )
                .toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      StatCard(
                        title: AppStrings.totalItems,
                        value: products.length.toString(),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: AppStrings.searchMenuItems,
                            hintStyle: theme.textTheme.bodySmall?.copyWith(
                              color: theme.hintColor,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppColors.containerBorder,
                              ),
                            ),
                            suffixIcon: Icon(
                              Icons.search,
                              color: theme.iconTheme.color,
                            ),
                          ),
                          onChanged: onSearchChanged,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: products.isEmpty
                      ? Center(
                          child: Text(
                            AppStrings.noProductsFound,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.hintColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(8),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCard(
                              product: product,
                              onEdit: () async {
                                final updated = await navigator.push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ProductFormPage(product: product),
                                  ),
                                );
                                if (updated == true) {
                                  productBloc.add(LoadProductsEvent());
                                }
                              },
                              onDelete: () {
                                productBloc.add(
                                  DeleteProductEvent(product.id),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          } else if (state is ProductErrorState) {
            return Center(
              child: Text(
                '${AppStrings.errorOccurred}${state.message}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            );
          } else {
            return Center(
              child: Text(
                AppStrings.loading,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

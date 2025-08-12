import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/admin/admin_bloc.dart';
import 'package:project_iti_2025/core/constants/app_strings.dart';
import 'package:project_iti_2025/presentation/screens/admin/admin_add_screan.dart';
import 'package:project_iti_2025/presentation/screens/admin/admin_page_screan_content.dart';

class AdminProductsPage extends StatefulWidget {
  const AdminProductsPage({super.key});

  @override
  State<AdminProductsPage> createState() => _AdminProductsPageState();
}

class _AdminProductsPageState extends State<AdminProductsPage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navigator = Navigator.of(context);
    final productBloc = context.read<ProductBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.adminDashboard,
          style: theme.textTheme.headlineMedium,
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        leading: Icon(
          Icons.admin_panel_settings,
          size: 40,
          color: theme.appBarTheme.iconTheme?.color,
        ),
      ),
      body: AdminProductsScreenContent(
        searchQuery: searchQuery,
        onSearchChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        onPressed: () async {
          final updated = await navigator.push(
            MaterialPageRoute(builder: (_) => const ProductFormPage()),
          );
          if (updated == true) {
            productBloc.add(LoadProductsEvent());
          }
        },
        icon: const Icon(Icons.add),
        label: Text(
          AppStrings.addNewItem,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}

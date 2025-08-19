import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_iti_2025/blocs/delivery/delivery_bloc.dart';
import 'package:project_iti_2025/blocs/delivery/delivery_event.dart';
import 'package:project_iti_2025/blocs/delivery/delivery_state.dart';
import 'package:project_iti_2025/presentation/widgets/primary_botton.dart';
import 'package:project_iti_2025/core/constants/app_strings.dart';
import 'package:project_iti_2025/data/models/delivery/delivery_details.dart';

class DeliveryForm extends StatefulWidget {
  const DeliveryForm({super.key});

  @override
  State<DeliveryForm> createState() => _DeliveryFormState();
}

class _DeliveryFormState extends State<DeliveryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _instructionsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final details = DeliveryDetails(
        fullName: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        street: _streetController.text.trim(),
        city: _cityController.text.trim(),
        instructions: _instructionsController.text.trim().isEmpty
            ? null
            : _instructionsController.text.trim(),
      );

      context.read<DeliveryBloc>().add(SubmitDeliveryEvent(
            fullName: details.fullName,
            phone: details.phone,
            street: details.street,
            city: details.city,
            instructions: details.instructions ?? '',
          ));

      Navigator.of(context)
          .pushReplacementNamed('/confirm', arguments: details);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeliveryBloc, dynamic>(
      listener: (context, state) {
        if (state is DeliveryFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(AppStrings.fullName,
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Full name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            const Text(AppStrings.phoneNumber,
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                hintText: 'Phone number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              //validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'Required';
                }
                final regex =
                    RegExp(r'^[0-9]+$'); // ✅ تحقق أن الإدخال كله أرقام
                if (!regex.hasMatch(v)) {
                  return 'Phone number must contain digits only';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            const Text('Street Address',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              controller: _streetController,
              decoration: const InputDecoration(
                hintText: 'Street address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            const Text('City', style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(
                hintText: 'City',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_city),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            const Text('Delivery Instructions (optional)',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              controller: _instructionsController,
              decoration: const InputDecoration(
                hintText: 'Any notes...',
                border: OutlineInputBorder(),
                //prefixIcon: Icon(Icons.note),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 18),
            PrimaryButton(
              text: AppStrings.continueToOrder,
              onPressed: _submit,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

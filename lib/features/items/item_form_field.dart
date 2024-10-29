import 'package:flutter/material.dart';

class ItemFormField extends StatelessWidget {
  const ItemFormField({
    required this.controller,
    required this.label,
    super.key,
    this.hintText = '',
    this.validator,
    this.maxLines = 1,
  });
  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            hintText: hintText,
            border: const OutlineInputBorder(),
          ),
          validator: validator,
          maxLines: maxLines,
        ),
      ],
    );
  }
}

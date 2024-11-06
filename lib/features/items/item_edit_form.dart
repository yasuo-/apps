// lib/features/items/item_edit_form.dart

import 'package:apps/features/items/logic/item_edit_controller.dart';
import 'package:apps/models/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemEditForm extends StatefulWidget {
  const ItemEditForm({super.key});

  @override
  _ItemEditFormState createState() => _ItemEditFormState();
}

class _ItemEditFormState extends State<ItemEditForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;
  late TextEditingController _countController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = Provider.of<ItemEditController>(context);
    final item = controller.item!;
    _nameController = TextEditingController(text: item.name);
    _locationController = TextEditingController(text: item.location);
    _descriptionController = TextEditingController(text: item.description);
    _countController = TextEditingController(text: item.count.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ItemEditController>(context);

    return Form(
      key: _formKey,
      child: ListView(
        children: [
          const SizedBox(height: 24),
          const Text('備品名'),
          const SizedBox(height: 8),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: '備品名',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '備品名を入力してください';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          const Text('保存場所'),
          const SizedBox(height: 8),
          TextFormField(
            controller: _locationController,
            decoration: const InputDecoration(
              labelText: '保存場所',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '保存場所を入力してください';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          const Text('個数'),
          const SizedBox(height: 8),
          TextFormField(
            controller: _countController,
            decoration: const InputDecoration(
              labelText: '個数(数字のみ)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '個数を入力してください';
              }
              if (int.tryParse(value) == null) {
                return '数字を入力してください';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          const Text('備品内容'),
          const SizedBox(height: 8),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: '備品内容',
              border: OutlineInputBorder(),
              hintText: '備品の詳細を入力してください',
            ),
            maxLines: 5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '備品内容を入力してください';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: controller.isSubmitting
                ? null
                : () async {
                    if (_formKey.currentState!.validate()) {
                      final updatedItem = Item(
                        id: controller.item!.id,
                        name: _nameController.text,
                        description: _descriptionController.text,
                        location: _locationController.text,
                        count: int.parse(_countController.text),
                        createdAt: controller.item!.createdAt,
                      );
                      await controller.updateItem(updatedItem);
                      if (controller.error == null) {
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('エラー: ${controller.error}'),
                          ),
                        );
                      }
                    }
                  },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
            ),
            child: controller.isSubmitting
                ? const CircularProgressIndicator()
                : const Text('更新する'),
          ),
        ],
      ),
    );
  }
}

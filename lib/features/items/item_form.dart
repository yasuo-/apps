import 'package:apps/features/items/item_form_field.dart';
import 'package:flutter/material.dart';

/// 備品のフォームウィジェット
class ItemForm extends StatefulWidget {
  const ItemForm({
    required this.onSaved,
    super.key,
    this.initialName,
    this.initialLocation,
    this.initialDescription,
  });
  final VoidCallback onSaved;
  final String? initialName;
  final String? initialLocation;
  final String? initialDescription;

  @override
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _locationController = TextEditingController(text: widget.initialLocation);
    _descriptionController =
        TextEditingController(text: widget.initialDescription);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final location = _locationController.text;
      final description = _descriptionController.text;

      // 任意のデータ処理を実行 (例: データの保存)
      print('Name: $name');
      print('Location: $location');
      print('Description: $description');

      // フォームのリセット
      _formKey.currentState!.reset();
      _nameController.clear();
      _locationController.clear();
      _descriptionController.clear();

      // 保存処理が完了したことを通知
      widget.onSaved();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemFormField(
            controller: _nameController,
            label: '備品名',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '備品名を入力してください';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ItemFormField(
            controller: _locationController,
            label: '保存場所',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '保存場所を入力してください';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ItemFormField(
            controller: _descriptionController,
            label: '備品内容',
            hintText: 'Type your message...',
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
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: const Text('送信する'),
          ),
        ],
      ),
    );
  }
}

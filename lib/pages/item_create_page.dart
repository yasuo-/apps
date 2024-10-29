import 'package:flutter/material.dart';

class ItemCteatePage extends StatefulWidget {
  const ItemCteatePage({super.key});

  @override
  _ItemCteatePageState createState() => _ItemCteatePageState();
}

class _ItemCteatePageState extends State<ItemCteatePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // フォームが有効な場合、データを処理
      final name = _nameController.text;
      final location = _locationController.text;
      final description = _descriptionController.text;

      // データを保存する、またはAPIに送信する処理を追加
      print('Name: $name');
      print('Location: $location');
      print('Description: $description');

      // フォームのリセット
      _formKey.currentState!.reset();
      _nameController.clear();
      _locationController.clear();
      _descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('備品作成'),
      ),
      body: Center(
        child: Container(
          width: 1000, // コンテナの幅
          padding: const EdgeInsets.only(
            top: 24,
            bottom: 24,
          ), // コンテナのpadding 縦のみ
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '備品作成',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '備品を追加して下さい',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        controller: _locationController,
                        decoration: const InputDecoration(
                          labelText: '個数(数字のみ)',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '個数を入力してください';
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
                          hintText: 'Type your message...',
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
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black, // ボタンテキストの色
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: const Text('登録する'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ItemEditPage extends StatefulWidget {
  const ItemEditPage({
    required this.itemId,
    super.key,
  });

  final String itemId;

  @override
  _ItemEditPageState createState() => _ItemEditPageState();
}

class _ItemEditPageState extends State<ItemEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isLoading = true; // データ取得中の状態を管理

  @override
  void initState() {
    super.initState();
    _fetchItemData(); // APIデータ取得メソッドを呼び出し
  }

  // 仮のAPIからデータを取得するメソッド
  Future<void> _fetchItemData() async {
    // APIからデータを取得する仮の遅延を設定
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _nameController.text = 'サンプル備品名';
        _locationController.text = '倉庫A';
        _descriptionController.text = 'この備品はサンプルの説明';
        _isLoading = false; // データ取得完了
      });
    });
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
        title: const Text('備品編集'),
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
                        '備品編集',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '備品を編集して下さい',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _isLoading
                    ? const Text('データ取得中...') // データ取得中表示
                    : Form(
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
                              child: const Text('送信する'),
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

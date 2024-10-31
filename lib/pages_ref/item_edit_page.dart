import 'package:apps/features/items/item_form.dart';
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
  String? _initialName;
  String? _initialLocation;
  String? _initialDescription;

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
        _initialName = 'サンプル備品名';
        _initialLocation = '倉庫A';
        _initialDescription = 'この備品はサンプルの説明';
        _isLoading = false; // データ取得完了
      });
    });
  }

  void _onSaved() {
    print('アイテムが正常に編集されました。');
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
                    : ItemForm(
                        onSaved: _onSaved,
                        initialName: _initialName,
                        initialLocation: _initialLocation,
                        initialDescription: _initialDescription,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

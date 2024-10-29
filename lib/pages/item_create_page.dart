import 'package:apps/features/items/item_form.dart';
import 'package:flutter/material.dart';

class ItemCreatePage extends StatelessWidget {
  const ItemCreatePage({super.key});

  void _onSaved() {
    // 登録ボタン押下時の処理
    print('アイテムが正常に作成されました。');
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
                child: ItemForm(
                  onSaved: _onSaved,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

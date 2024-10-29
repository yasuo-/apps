import 'package:apps/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({required this.itemId, super.key});
  final String itemId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('備品詳細: $itemId'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const HeaderWidget(
                    title: '備品管理詳細',
                    subtitle: '備品管理詳細テキストテキストテキストテキスト',
                  ),
                  ElevatedButton(
                    onPressed: () => context.go('/items/$itemId/edit'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                    child: const Text('編集'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // 画像 (ダミー)
                    Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.image,
                        color: Colors.grey,
                        size: 100,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // カテゴリーと日付
                    const Row(
                      children: [
                        Text(
                          'Category: カテゴリー',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    const Text(
                      '2024/10/10: 登録',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),

                    // アイテムタイトルと詳細
                    const Text(
                      '備品名',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '備品内容が入ります。備品内容が入ります\n'
                      '備品内容が入ります。備品内容が入ります\n'
                      '備品内容が入ります。備品内容が入ります\n'
                      '備品内容が入ります。備品内容が入ります\n'
                      '備品内容が入ります。備品内容が入ります',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    // ロケーション情報
                    const Text(
                      'ロケーション：',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'ロケーション情報が入ります。',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

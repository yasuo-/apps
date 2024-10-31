import 'package:apps/features/items/logic/item_detail_controller.dart';
import 'package:apps/repositories/item_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({required this.itemId, super.key});
  final String itemId;

  @override
  Widget build(BuildContext context) {
    // ProviderからDioのインスタンスを取得
    final dio = Provider.of<Dio>(context);

    return ChangeNotifierProvider<ItemDetailController>(
      create: (_) => ItemDetailController(ItemRepository(dio), itemId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('備品詳細'),
        ),
        body: Center(
          child: Container(
            width: 1000,
            padding: const EdgeInsets.only(
              top: 24,
              bottom: 24,
            ),
            child: Consumer<ItemDetailController>(
              builder: (context, controller, child) {
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.error != null) {
                  return Center(
                    child: Text('エラー: ${controller.error}'),
                  );
                } else if (controller.item == null) {
                  return const Center(
                    child: Text('アイテムが見つかりません'),
                  );
                } else {
                  final item = controller.item!;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '備品管理',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '備品管理詳細テキストテキストテキストテキスト',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () =>
                                    context.go('/items/${item.id}/edit'),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.black,
                                ),
                                child: const Text('編集'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
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
                              Text(
                                'Category: ${item.location}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '${item.createdAt.toLocal().toString().split(' ')[0]}: 登録',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // アイテムタイトルと詳細
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                item.description,
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 16),
                              // ロケーション情報
                              const Text(
                                'ロケーション：',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.location,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

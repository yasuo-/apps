import 'package:apps/features/items/logic/item_edit_controller.dart';
import 'package:apps/models/item.dart';
import 'package:apps/repositories/item_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 注意: このファイルはWidget分けをまだ行っていないです。
class ItemEditPage extends StatelessWidget {
  const ItemEditPage({required this.itemId, super.key});

  final String itemId;

  @override
  Widget build(BuildContext context) {
    // ProviderからDioのインスタンスを取得
    final dio = Provider.of<Dio>(context, listen: false);

    return ChangeNotifierProvider<ItemEditController>(
      create: (_) => ItemEditController(ItemRepository(dio), itemId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('備品編集'),
        ),
        body: Center(
          child: Container(
            width: 1000, // コンテナの幅
            padding: const EdgeInsets.only(
              top: 24,
              bottom: 24,
            ), // コンテナの縦方向のパディング
            child: Column(
              children: [
                // ヘッダー部分
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ヘッダーウィジェット
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
                          '備品を編集してください',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Consumer<ItemEditController>(
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
                        final formKey = GlobalKey<FormState>();
                        final nameController = TextEditingController(
                          text: controller.item!.name,
                        );
                        final locationController = TextEditingController(
                          text: controller.item!.location,
                        );
                        final descriptionController = TextEditingController(
                          text: controller.item!.description,
                        );
                        final countController = TextEditingController(
                          text: controller.item!.count.toString(),
                        );

                        return Form(
                          key: formKey,
                          child: ListView(
                            children: [
                              const SizedBox(height: 24),
                              const Text('備品名'),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: nameController,
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
                                controller: locationController,
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
                                controller: countController,
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
                                controller: descriptionController,
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
                                        if (formKey.currentState!.validate()) {
                                          final updatedItem = Item(
                                            id: controller.item!.id,
                                            name: nameController.text,
                                            description:
                                                descriptionController.text,
                                            location: locationController.text,
                                            count: int.parse(
                                              countController.text,
                                            ),
                                            createdAt:
                                                controller.item!.createdAt,
                                          );
                                          await controller
                                              .updateItem(updatedItem);
                                          if (controller.error == null) {
                                            // 成功した場合の処理
                                            Navigator.pop(context);
                                          } else {
                                            // エラーがある場合の処理
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'エラー: ${controller.error}',
                                                ),
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
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

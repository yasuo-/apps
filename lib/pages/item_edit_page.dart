import 'package:apps/features/items/item_edit_form.dart';
import 'package:apps/features/items/logic/item_edit_controller.dart';
import 'package:apps/repositories/item_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemEditPage extends StatelessWidget {
  const ItemEditPage({required this.itemId, super.key});

  final String itemId;

  @override
  Widget build(BuildContext context) {
    final dio = Provider.of<Dio>(context, listen: false);

    return ChangeNotifierProvider<ItemEditController>(
      create: (_) => ItemEditController(ItemRepository(dio), itemId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('備品編集'),
        ),
        body: Center(
          child: Container(
            width: 1000,
            padding: const EdgeInsets.only(
              top: 24,
              bottom: 24,
            ),
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
                        return const ItemEditForm();
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

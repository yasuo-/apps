import 'package:apps/features/items/item_create_form.dart';
import 'package:apps/features/items/logic/item_create_controller.dart';
import 'package:apps/repositories/item_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemCreatePage extends StatelessWidget {
  const ItemCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Provider.of<Dio>(context, listen: false);

    return ChangeNotifierProvider<ItemCreateController>(
      create: (_) => ItemCreateController(ItemRepository(dio)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('備品作成'),
        ),
        body: Center(
          child: Container(
            width: 1000,
            padding: const EdgeInsets.only(
              top: 24,
              bottom: 24,
            ),
            child: const Column(
              children: [
                // ヘッダー部分
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ヘッダーウィジェット
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
                          '備品を追加してください',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // フォーム部分
                Expanded(
                  child: ItemCreateForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

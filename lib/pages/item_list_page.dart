import 'package:apps/features/items/logic/item_list_controller.dart';
import 'package:apps/repositories/item_repository.dart';
import 'package:apps/router.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ItemListPage extends StatelessWidget {
  const ItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ProviderからDioのインスタンスを取得
    final dio = Provider.of<Dio>(context);

    return ChangeNotifierProvider<ItemListController>(
      create: (_) => ItemListController(ItemRepository(dio)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('備品一覧'),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '備品管理一覧',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '備品管理テキストテキストテキストテキスト',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            // Export処理を実装
                          },
                          child: const Text(
                            'CSV Export',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () => context.go(RoutePaths.itemCreate),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black, // ボタンテキストの色
                          ),
                          child: const Text('追加する'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Consumer<ItemListController>(
                    builder: (context, controller, child) {
                      if (controller.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (controller.error != null) {
                        return Center(
                          child: Text('エラー: ${controller.error}'),
                        );
                      } else {
                        // DataTableでデータを表示
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FittedBox(
                            child: DataTable(
                              border: const TableBorder(
                                top: BorderSide(color: Colors.grey),
                                bottom: BorderSide(color: Colors.grey),
                                left: BorderSide(color: Colors.grey),
                                right: BorderSide(color: Colors.grey),
                                horizontalInside:
                                    BorderSide(color: Colors.grey),
                              ),
                              showCheckboxColumn: false,
                              columns: const [
                                DataColumn(
                                  label: SizedBox(
                                    width: 120,
                                    child: Text('備品名'),
                                  ),
                                ),
                                DataColumn(
                                  label: SizedBox(
                                    width: 250,
                                    child: Text('備品内容'),
                                  ),
                                ),
                                DataColumn(label: Text('作成日')),
                                DataColumn(label: Text('個数')),
                                DataColumn(label: Text('')),
                              ],
                              rows: controller.items.map((item) {
                                return DataRow(
                                  cells: [
                                    DataCell(Text(item.name)),
                                    DataCell(Text(item.description)),
                                    DataCell(
                                      Text(
                                        item.createdAt
                                            .toLocal()
                                            .toString()
                                            .split(' ')[0], // 日付のみ表示
                                      ),
                                    ),
                                    DataCell(Text(item.count.toString())),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(Icons.more_vert),
                                        onPressed: () {
                                          // 追加の操作
                                        },
                                      ),
                                    ),
                                  ],
                                  onSelectChanged: (isSelected) {
                                    // 選択処理
                                    context.go('/items/${item.id}');
                                  },
                                );
                              }).toList(),
                            ),
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

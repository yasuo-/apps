import 'package:apps/widgets/button_group_widget.dart';
import 'package:apps/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemListPage extends StatelessWidget {
  const ItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 背景色
      appBar: AppBar(
        title: const Text('備品一覧'),
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
                    title: '備品管理一覧',
                    subtitle: '備品管理テキストテキストテキストテキスト',
                  ),
                  ButtonGroupWidget(
                    onExport: () {
                      // Export処理を実装
                    },
                    onAdd: () => context.go('/items/create'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // 横スクロール
                  child: FittedBox(
                    child: DataTable(
                      border: const TableBorder(
                        top: BorderSide(color: Colors.grey), // 上部の枠線
                        bottom: BorderSide(color: Colors.grey), // 下部の枠線
                        left: BorderSide(color: Colors.grey), // 左の枠線
                        right: BorderSide(color: Colors.grey), // 右の枠線
                        horizontalInside:
                            BorderSide(color: Colors.grey), // 行の間の枠線
                      ), // テーブルの枠線
                      showCheckboxColumn: false, // チェックボックスを非表示
                      columns: const [
                        // テーブルのヘッダー
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
                        DataColumn(label: Text('Created')),
                        DataColumn(label: Text('Count')),
                        DataColumn(label: Text('')),
                      ],
                      rows: // テーブルのデータ
                          List<DataRow>.generate(
                        10,
                        (index) => DataRow(
                          cells: [
                            const DataCell(Text('備品名が入ります')),
                            const DataCell(Text('備品内容が入ります。備品内容が入ります')),
                            const DataCell(Text('2025/11/1')),
                            DataCell(Text((index * 2).toString())),
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
                            context.go('/items/$index');
                          },
                        ),
                      ),
                    ),
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

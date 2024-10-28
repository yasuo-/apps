import 'package:apps/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemListPage extends StatelessWidget {
  const ItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go(RoutePaths.itemCreate),
              child: const Text('Create Item'),
            ),
            const SizedBox(height: 20),
            // ListViewをExpandedでラップして、明確な高さの制約を与える
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Item $index'),
                    onTap: () => context.go('/items/$index'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

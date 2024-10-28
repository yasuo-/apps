import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({required this.itemId, super.key});
  final String itemId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Detail: $itemId'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Details for Item $itemId'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/items/$itemId/edit'),
              child: const Text('Go Edit Item'),
            ),
          ],
        ),
      ),
    );
  }
}

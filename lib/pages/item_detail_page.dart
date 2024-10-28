import 'package:flutter/material.dart';

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
        child: Text('Details for Item $itemId'),
      ),
    );
  }
}

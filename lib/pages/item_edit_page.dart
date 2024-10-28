import 'package:flutter/material.dart';

class ItemEditPage extends StatelessWidget {
  const ItemEditPage({required this.itemId, super.key});
  final String itemId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Edit: $itemId'),
      ),
      body: Center(
        child: Text('Edit for Item $itemId'),
      ),
    );
  }
}

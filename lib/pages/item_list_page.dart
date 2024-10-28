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
    );
  }
}

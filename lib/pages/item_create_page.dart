import 'package:flutter/material.dart';

class ItemCreatePage extends StatelessWidget {
  const ItemCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Create'),
      ),
      body: const Center(
        child: Text('Item Create'),
      ),
    );
  }
}

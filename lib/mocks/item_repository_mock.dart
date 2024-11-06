import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class ItemRepositoryMock {
  ItemRepositoryMock(Dio dio) : _adapter = DioAdapter(dio: dio) {
    _setupMock();
  }
  final DioAdapter _adapter;

  void _setupMock() {
    _adapter
      ..onGet(
        '/items',
        (server) => server.reply(200, [
          {
            'id': '1',
            'name': 'サンプル備品',
            'description': 'これはサンプル備品の説明です。',
            'location': '倉庫A',
            'count': 5,
            'created_at': '2024-10-30T12:34:56.789Z',
          },
          {
            'id': '2',
            'name': '別の備品',
            'description': 'これは別の備品の説明です。',
            'location': '倉庫B',
            'count': 10,
            'created_at': '2024-10-30T12:34:56.789Z',
          },
          {
            'id': '3',
            'name': 'さらに別の備品',
            'description': 'これはさらに別の備品の説明です。',
            'location': '倉庫C',
            'count': 15,
            'created_at': '2024-10-30T12:34:56.789Z',
          },
          {
            'id': '4',
            'name': '最後の備品',
            'description': 'これは最後の備品の説明です。',
            'location': '倉庫D',
            'count': 20,
            'created_at': '2024-10-30T12:34:56.789Z',
          },
          {
            'id': '5',
            'name': '新しい備品',
            'description': '新しい備品の説明です。',
            'location': '倉庫E',
            'count': 25,
            'created_at': '2024-10-30T12:34:56.789Z',
          }
        ]),
      )
      // アイテムの取得（GET /items/:id）
      ..onGet(
        RegExp(r'/items/\d+'),
        (server) => server.reply(200, {
          'id': '1',
          'name': 'サンプル備品',
          'description': 'これはサンプル備品の説明です。',
          'location': '倉庫A',
          'count': 5,
          'created_at': '2024-10-30T12:34:56.789Z',
        }),
      )
      // アイテムの作成（POST /items）
      ..onPost(
        '/items',
        data: {
          'items': {
            'name': '新しい備品', // 備品名に入力
            'description': '新しい備品の説明です。', // 備品内容に入力
            'location': '倉庫C', // 保存場所に入力
            'count': 8, //  個数に入力
          },
        },
        (server) => server.reply(201, {
          'name': '新しい備品',
          'description': '新しい備品の説明です。',
          'location': '倉庫C',
          'count': 8,
        }),
      )
      // アイテムの更新（PUT /items/:id）
      ..onPut(
        RegExp(r'/items/\d+'),
        data: {
          'items': {
            'name': '更新された備品', // 備品名に入力
            'description': '更新された備品の説明です。', // 備品内容に入力
            'location': '更新された倉庫', // 保存場所に入力
            'count': 15, //  個数に入力
          },
        },
        (server) => server.reply(200, {
          'id': '1',
          'name': '更新された備品',
          'description': '更新された備品の説明です。',
          'location': '更新された倉庫',
          'count': 15,
          'created_at': '2024-10-30T12:34:56.789Z',
        }),
      )
      // アイテムの削除（DELETE /items/:id）
      ..onDelete(
        RegExp(r'/items/\d+'),
        (server) => server.reply(204, {}),
      );
  }
}

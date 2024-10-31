import 'package:apps/models/item.dart';
import 'package:dio/dio.dart';

/// IItemRepositoryクラス
abstract class IItemRepository {
  Future<List<Item>> fetchItems();
  Future<Item> fetchItem(String id);
  Future<void> createItem(Item item);
  Future<void> updateItem(Item item);
  Future<void> deleteItem(String id);
}

/// ItemRepositoryクラス
class ItemRepository implements IItemRepository {
  ItemRepository(this._dio);
  final Dio _dio;

  /// 備品一覧を取得する
  @override
  Future<List<Item>> fetchItems() async {
    try {
      final response = await _dio.get<List<dynamic>>('/items');
      // 確認用に追加
      print('--fetchItems:response: $response');
      final data = response.data!;
      return data
          .map((json) => Item.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// 備品を取得する
  @override
  Future<Item> fetchItem(String id) async {
    try {
      final response = await _dio.get<dynamic>('/items/$id');
      final data = response.data;
      print('fetchItem data: $data');
      return Item.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// 備品を作成する
  @override
  Future<void> createItem(Item item) async {
    try {
      final body = item.toJson();
      await _dio.post<void>('/items', data: body);
    } catch (e) {
      print('Error in createItem: $e');
      rethrow;
    }
  }

  /// 備品を更新する
  @override
  Future<void> updateItem(Item item) async {
    try {
      await _dio.put<void>('/items/${item.id}', data: item.toJson());
    } catch (e) {
      rethrow;
    }
  }

  /// 備品を削除する
  @override
  Future<void> deleteItem(String id) async {
    try {
      await _dio.delete<void>('/items/$id');
    } catch (e) {
      rethrow;
    }
  }
}

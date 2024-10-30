// File: test/repositories/item_repository_test.dart
import 'package:apps/mocks/item_repository_mock.dart';
import 'package:apps/repositories/item_repository.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

void main() {
  late Dio dio;
  late ItemRepository itemRepository;

  setUp(() {
    dio = Dio();
    ItemRepositoryMock(dio); // モック設定を適用
    itemRepository = ItemRepository(dio);
  });

  group('ItemRepository Test', () {
    test('fetchItems executes successfully', () async {
      // expect(); 条件を満たすかどうかを確認する
      // returnsNormally: 例外エラーが発生しないことを確認する
      expect(() async => itemRepository.fetchItems(), returnsNormally);
    });
  });
}

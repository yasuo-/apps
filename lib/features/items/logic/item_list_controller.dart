import 'package:apps/logic/base_controller.dart';
import 'package:apps/models/item.dart';
import 'package:apps/repositories/item_repository.dart';

/// item list controller interface
abstract class IItemListController extends IBaseController {
  List<Item> get items;
  Future<void> fetchItems();
}

/// item list controller
class ItemListController extends BaseController implements IItemListController {
  ItemListController(this._repository) {
    fetchItems();
  }

  final IItemRepository _repository;
  List<Item> _items = [];

  @override
  List<Item> get items => _items;

  @override
  Future<void> fetchItems() async {
    try {
      setLoading(true);
      _items = await _repository.fetchItems();
      setLoading(false);
    } catch (e) {
      setError(e.toString());
      setLoading(false);
    }
  }
}

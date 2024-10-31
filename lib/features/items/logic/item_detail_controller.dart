import 'package:apps/logic/base_controller.dart';
import 'package:apps/models/item.dart';
import 'package:apps/repositories/item_repository.dart';

/// item detail controller interface
abstract class IItemDetailController extends IBaseController {
  Item? get item;
  Future<void> fetchItem();
}

/// item detail controller class
class ItemDetailController extends BaseController
    implements IItemDetailController {
  ItemDetailController(this._repository, this.itemId) {
    fetchItem();
  }

  final IItemRepository _repository;
  final String itemId;

  Item? _item;

  @override
  Item? get item => _item;

  @override
  Future<void> fetchItem() async {
    try {
      setLoading(true);
      _item = await _repository.fetchItem(itemId);
      setLoading(false);
    } catch (e) {
      setError(e.toString());
      setLoading(false);
    }
  }
}

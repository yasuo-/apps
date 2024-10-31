import 'package:apps/logic/base_controller.dart';
import 'package:apps/models/item.dart';
import 'package:apps/repositories/item_repository.dart';

/// item edit controller interface
abstract class IItemEditController extends IBaseController {
  Item? get item;
  bool get isSubmitting;
  // ignore: avoid_positional_boolean_parameters
  void setSubmitting(bool value);
  Future<void> fetchItem();
  Future<void> updateItem(Item item);
}

/// item edit controller class
class ItemEditController extends BaseController implements IItemEditController {
  ItemEditController(this._repository, this.itemId) {
    fetchItem();
  }

  final IItemRepository _repository;
  final String itemId;

  Item? _item;
  bool _isSubmitting = false;

  @override
  Item? get item => _item;
  @override
  bool get isSubmitting => _isSubmitting;

  @override
  void setSubmitting(bool value) {
    _isSubmitting = value;
    notifyListeners();
  }

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

  @override
  Future<void> updateItem(Item item) async {
    try {
      setSubmitting(true);
      await _repository.updateItem(item);
      setSubmitting(false);
    } catch (e) {
      setError(e.toString());
      setSubmitting(false);
    }
  }
}

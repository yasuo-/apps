import 'package:apps/logic/base_controller.dart';
import 'package:apps/models/item.dart';
import 'package:apps/repositories/item_repository.dart';

/// item create controller interface
abstract class IItemCreateController extends IBaseController {
  bool get isSubmitting;
  // ignore: avoid_positional_boolean_parameters
  void setSubmitting(bool value);
  Future<void> createItem(Item item);
}

/// item create controller class
class ItemCreateController extends BaseController
    implements IItemCreateController {
  ItemCreateController(this._repository);

  final IItemRepository _repository;
  bool _isSubmitting = false;

  @override
  bool get isSubmitting => _isSubmitting;

  // ignore: avoid_positional_boolean_parameters
  @override
  void setSubmitting(bool value) {
    _isSubmitting = value;
    notifyListeners();
  }

  /// create item
  @override
  Future<void> createItem(Item item) async {
    try {
      setSubmitting(true);
      await _repository.createItem(item);
      setSubmitting(false);
    } catch (e) {
      setError(e.toString());
      setSubmitting(false);
    }
  }
}

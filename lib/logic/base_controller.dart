import 'package:flutter/foundation.dart';

/// base controller interface
abstract class IBaseController implements Listenable {
  bool get isLoading;
  String? get error;

  // ignore: avoid_positional_boolean_parameters
  void setLoading(bool value);
  void setError(String? value);
}

/// base controller class
abstract class BaseController extends ChangeNotifier
    implements IBaseController {
  bool _isLoading = false;
  String? _error;

  @override
  bool get isLoading => _isLoading;
  @override
  String? get error => _error;

  // ignore: avoid_positional_boolean_parameters
  @override
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void setError(String? value) {
    _error = value;
    notifyListeners();
  }
}

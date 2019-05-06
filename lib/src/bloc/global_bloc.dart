import 'package:rxdart/rxdart.dart';

class GlobalBoc {
  BehaviorSubject<bool> _loadingController = BehaviorSubject<bool>();

  Observable get loadingStream$ => _loadingController.stream;

  bool get isLoading => _loadingController.value;
  
  toggleLoading() {
    _loadingController.add(!isLoading);
  }

  dispose() {
    _loadingController.close();
  }
}
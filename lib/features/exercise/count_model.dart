import 'package:flutter/foundation.dart';

class CountModel extends ChangeNotifier {
  int _mCount = 0;

  int get count => _mCount;

  void incrementCount(int newCount) {
    // count를 아무리 해도 올라가지 않는다, 1로만 유지될뿐인 상황이다
    _mCount = newCount;
    print("incrementCount is called: $_mCount");
    notifyListeners();
  }
}

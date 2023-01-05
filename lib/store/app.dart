import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  bool _isGrayFilter = false;
  get isGrayFilter => _isGrayFilter;

  AppState({bool isGrayFilter = false}) {
    _isGrayFilter = isGrayFilter;
  }

  // 切换灰色滤镜
  switchGrayFilter() {
    _isGrayFilter = !_isGrayFilter;
    notifyListeners();
  }
}

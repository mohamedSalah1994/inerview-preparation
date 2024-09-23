import 'package:flutter/material.dart';

import '../../data/repos/tip_repo.dart';

class TipProvider with ChangeNotifier {
  final TipRepoImpl _tipRepoImpl = TipRepoImpl();

  List<Map<String, dynamic>> _tips = [];
  List<Map<String, dynamic>> get tips => _tips;

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchTips() async {
    _isLoading = true;
    notifyListeners();
    
    final result = await _tipRepoImpl.getTips();
    
    result.fold(
      (failure) {
        _errorMessage = failure.message;
        debugPrint('Error fetching tips: $_errorMessage');
        _tips = []; // Clear tips on error
      },
      (fetchedTips) {
        _tips = fetchedTips.cast<Map<String, dynamic>>();
        debugPrint('Tips loaded: $_tips');
      },
    );

    _isLoading = false;
    notifyListeners();
  }


}

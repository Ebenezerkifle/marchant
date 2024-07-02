import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PageBuilderViewModel extends BaseViewModel {
  late PageController _pageController;
  PageController get pageController => _pageController;

  int _currentPage = 0;
  int get currentPage => _currentPage;

  PageBuilderViewModel() {
    _pageController = PageController();
  }

  void onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void goToPreviousPage() {
    if (_pageController.hasClients) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void goToNextPage() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

// import 'package:marchant/enums/user_role.dart';
// import 'package:stacked/stacked.dart';

// class LandingStateService with ListenableServiceMixin {
//   LandingStateService() {
//     listenToReactiveValues([_userRole, _currentIndex]);
//   }

//   final _currentIndex = ReactiveValue(0);
//   int get currentIndex => _currentIndex.value;

//   bool _reverse = false;

//   bool get reverse => _reverse;

//   void setIndex(int value) {
//     if (value < _currentIndex.value) {
//       _reverse = true;
//     } else {
//       _reverse = false;
//     }
//     _currentIndex.value = value;
//     notifyListeners();
//   }

//   final _userRole = ReactiveValue<UserRole>(UserRole.retailor);
//   UserRole get userRole => _userRole.value;

//   clearState() {
//     _currentIndex.value = 0;
//     notifyListeners();
//   }
// }




import 'package:marchant/enums/user_role.dart';
import 'package:stacked/stacked.dart';

class LandingStateService with ListenableServiceMixin{
 LandingStateService() {
    listenToReactiveValues([_userRole, _currentIndex]);
  }

  final _currentIndex = ReactiveValue<int>(0);
  int get currentIndex => _currentIndex.value;

  bool _reverse = false;

  bool get reverse => _reverse;

  void setIndex(int value) {
    if (value < _currentIndex.value) {
      _reverse = true;
    } else {
      _reverse = false;
    }
    _currentIndex.value = value;
    notifyListeners();
  }

  final _userRole = ReactiveValue<UserRole>(UserRole.retailor);
  UserRole get userRole => _userRole.value;

  // void setUserRole(UserRole role) {
  //   _userRole.value = role;
  //   notifyListeners();
  // }


void setUserRole(String? roleString) {
  if (roleString == null) {
    return; // Handle null case as needed
  }

  // Convert roleString to UserRole enum
  UserRole? role;
  if (roleString.toLowerCase() == 'retailor') {
    role = UserRole.retailor;
  } else if (roleString.toLowerCase() == 'manufacturer') {
    role = UserRole.manufacturer;
  } else {
    // Handle unknown role case
    return; // or throw an exception, log an error, etc.
  }

  _userRole.value = role;
  notifyListeners();
}


  void clearState() {
    _currentIndex.value = 0;
    _userRole.value = UserRole.retailor;

    notifyListeners();
  }
}

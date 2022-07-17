import 'package:flutter/cupertino.dart';
import 'package:pushit/features/auth/model/usermodel.dart';

class UserProvider extends ChangeNotifier {  


  User _user = User(
    id: '',
    name: '',
    password: '',
    email: '',
    address: '',
    type: '',
    token: '',
   // cart: [],
  );

  get getUser => _user;

  set setUserData(User user) {
    _user = user;
    notifyListeners();
  }
  
}

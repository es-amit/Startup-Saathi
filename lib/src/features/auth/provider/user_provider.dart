import 'package:flutter/material.dart';
import 'package:startup_saathi/src/features/auth/data/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  final UserModel _user = UserModel(
    email: '',
    phoneNumber: '',
  );

  UserModel get user => _user;

  void updateUserInRegister(String email, String phoneNumber) {
    _user.email = email;
    _user.phoneNumber = phoneNumber;

    notifyListeners();
  }

  void updateUserInPersonalDetail(
      String firstName, String lastName, String city) {
    _user.firstName = firstName;
    _user.lastName = lastName;
    _user.city = city;

    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_project_mvvm/core/enums/view_state.dart';
import 'package:weather_project_mvvm/core/services/authentication_api.dart';
import 'package:weather_project_mvvm/core/view_models/base_view_model.dart';
import 'package:weather_project_mvvm/locator.dart';

class SignInViewModel extends BaseViewModel {
  //final AuthenticationAPI _SignIn = locator<AuthenticationAPI>();
  final AuthenticationAPI _authenticationAPI = locator<AuthenticationAPI>();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isMobileNumberVisible = false;
  // bool get isPasswordVisible => _isPasswordVisible;
  void changeIsPasswordVisible() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void changeIsMobileNumberVisible() {
    isMobileNumberVisible = !isMobileNumberVisible;
    notifyListeners();
  }

  // Future<bool> signIn() async {
  //   setViewState(ViewState.busy);
  //
  //   int returnValue = await _SignIn.signInAPI(
  //       mobileNumberController.text, passwordController.text);
  //   setViewState(ViewState.idle);
  //   return returnValue == 200 ? true : false;
  // }
  //

  ///-------------------------sharepreference

  Future<void> setSavedPassword() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    mobileNumberController.text = preferences.getString('savemobile') ?? '';
    passwordController.text = preferences.getString('password') ?? '';
  }

  //function
  Future<bool> signIn() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    setViewState(ViewState.busy);
    int? returnedStatusCode = await _authenticationAPI.signInAPI(
        mobileNumberController.text, passwordController.text);
    setViewState(ViewState.idle);
    if (returnedStatusCode == 201) {
      if (isCheck) {
        preferences.setString('savemobile', mobileNumberController.text);
        preferences.setString('password', passwordController.text);
      } else {
        preferences.remove('savemobile');
        preferences.remove('password');
      }

      return true;
    } else {
      preferences.remove('savemobile');
      preferences.remove('password');
      return false;
    }
  }

  bool isCheck = true;
  void isCheckToogle() {
    isCheck = !isCheck;
    notifyListeners();
  }

  ///--------------------uI validation----------

  final GlobalKey<FormState> formKey = GlobalKey();
  String? mobilenumberValidator(String value) {
    String pattern = r'(^(01)[0-9]{9}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'মোবাইল নম্বর প্রয়োজন';
    } else if (!regExp.hasMatch(value)) {
      return '';
    }
    return null;
  }

  String? passwordValidator(String value) {
    print(value);
    String pattern = r"(^[a-zA-Z\d@%+'!#$^?:.~\-_.]{8,256}$)";
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'পাসওয়ার্ড প্রয়োজন';
    } else if (value.length < 8) {
      return 'কমপক্ষে ৮ অক্ষর বা তার বেশি প্রয়োজন';
    } else if (!regExp.hasMatch(value)) {
      return 'ভুল অক্ষর ব্যবহার করা হয়েছে';
    }
    return null;
  }
}

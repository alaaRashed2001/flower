import 'package:flutter/cupertino.dart';



/// هل هو ادمن ولا مستخدم عادي
class AdminMode extends ChangeNotifier{
  bool isAdmin = false;
  changeisAdmin(bool value){
    isAdmin = value;
    notifyListeners();
  }
}
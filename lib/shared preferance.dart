import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/main.dart';

class SharedPreferance {
  late SharedPreferance sharedPreferance;
  init() async{
    sharedPreferences = await SharedPreferences.getInstance();

  }
}
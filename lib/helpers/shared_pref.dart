import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<void>storeUser(String user) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setString('user', user);
  }

  Future<String?>getUser() async{
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString('user');
  }

  Future<void>removeUser() async{
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.remove('user');
  }
}
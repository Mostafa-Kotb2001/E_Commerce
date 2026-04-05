
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class InitServices extends GetxService{
  SharedPreferences? sharedPreferences ;

  Future<InitServices> init () async{

    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}
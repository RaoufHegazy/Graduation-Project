
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cache_helper {
  static SharedPreferences ? sharedPreferences ;

  static init()  async {
     sharedPreferences=  await SharedPreferences.getInstance();
  }

  static Future<bool> put_boolean(
      {@required String? key,@required bool ? value})
  {
    return sharedPreferences!.setBool(key!,value! );
  }

  static bool? get_boolean(
      {@required String? key})
  {
    return sharedPreferences!.getBool(key!);
  }


  static  Future<bool> save_data ({
    required String key,
    @required dynamic value,

  }) async
  {
    if(value is String) return await sharedPreferences!.setString(key, value);
    if(value is bool) return await sharedPreferences!.setBool(key, value);
    if(value is double) return await sharedPreferences!.setDouble(key, value);
    return await sharedPreferences!.setInt(key, value);
  }

  static  dynamic get_data ({
    required String key,
  })
  {

    return sharedPreferences?.get(key);
  }
  // future<dynamic>  will give an error in the main

  //cache_helper get data of different type


  static  Future<bool> remove_data ({
    required String key,

  }) async
  {
    return await sharedPreferences!.remove(key);
  }


}
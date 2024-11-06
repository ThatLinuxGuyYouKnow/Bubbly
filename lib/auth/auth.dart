import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_info/device_info.dart';

Future<String> getDeviceID() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String deviceID = await deviceInfo.androidInfo.toString();
  return deviceID;
}

/// all encompassing Auth Class
///
/// contains methods to sign in, sign out and create / sign up a new user
class Auth {
  signIn({required String username, required String password}) {
    String DeviceID = getDeviceID().toString();
    print('.......................log...............');
    print('sign in attempted');
    print(DeviceID);
  }

  /// use this function to sign the user in / create an acount
  ///
  /// takes username and password, already trimmed and validated from the controller
  signUp({required username, required password}) {}
}

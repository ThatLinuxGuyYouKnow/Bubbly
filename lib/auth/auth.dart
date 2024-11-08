import 'package:bubbly/data/localHandling/localData.dart';
import 'package:device_info/device_info.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_storage/get_storage.dart';

///TODO: Implement validation + local data storage of username
Future<String> getDeviceID() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String deviceID =
      (await deviceInfo.androidInfo).androidId ?? 'Unknown Device ID';
  return deviceID;
}

/// All-encompassing Auth Class
///
/// Contains methods to sign in, sign out, and create/sign up a new user.
class Auth {
  final supabase = Supabase.instance.client;

  Future<void> signIn({required String email, required String password}) async {
    final session = supabase.auth.currentUser;
    session != null ? print('User is authed') : print('Who dis?');
    await GetStorage.init();
    final box = GetStorage();

    try {
      // Await the asynchronous sign-in function
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthApiException catch (error) {
      // Handles API-specific errors
      print('Auth API Error: ${error.message}');
    } on AuthException catch (error) {
      // Catches general Supabase auth exceptions
      print('Auth Exception: ${error.message}');
    } catch (error) {
      // Catches any other errors that might occur
      print('Unexpected error: ${error.toString()}');
      final localData = LocalData();
      localData.storeEmail(email: email);
    }
  }

  /// Use this function to sign up a new user.
  ///
  /// Takes email and password, already trimmed and validated from the controller.
  Future<void> signUp({required String email, required String password}) async {
    try {
      print(email + "email sent to supabase");
      // Await the asynchronous sign-up function
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        print('Sign-up successful: ${response.user!.id}');
      } else {
        print('Sign-up failed: No user created');
      }
    } on AuthApiException catch (error) {
      // Handles API-specific errors
      print('Auth API Error: ${error.message}');
    } on AuthException catch (error) {
      // Catches general Supabase auth exceptions
      print('Auth Exception: ${error.message}');
    } catch (error) {
      // Catches any other errors that might occur
      print('Unexpected error: ${error.toString()}');
    }
    final localData = LocalData();
    localData.storeEmail(email: email);
  }

  signOut() async {
    final response = await supabase.auth.signOut();
    final data = LocalData();
    data.deleteUserData();
  }
}

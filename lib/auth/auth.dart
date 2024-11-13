import 'package:bubbly/data/localHandling/localData.dart';
import 'package:bubbly/data/localHandling/supabaseData.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

///TODO: Implement validation + local data storage of username
Future<String> getDeviceID() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String deviceID = (await deviceInfo.androidInfo).androidId;
  return deviceID;
}

/// All-encompassing Auth Class
///
/// Contains methods to sign in, sign out, and create/sign up a new user.
class Auth {
  final supabase = Supabase.instance.client;

  Future<void> signIn({
    required String email,
    required String password,
    required VoidCallback onSuccessfulAuth,
  }) async {
    try {
      // First sign in with Supabase
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Sign in failed - no user returned');
      }

      // Get username from Supabase BEFORE storing local data
      final supabaseData = SupabaseData();
      final username = await supabaseData.getUsernameFromEmail(email: email);

      if (username == null || username.isEmpty) {
        throw Exception('Username not found for email: $email');
      }

      // Store local data only after confirming we have valid data
      final localData = LocalData();
      await localData.storeEmail(email: email);
      await localData.storeUsername(username: username);
      print('stored email' + email);
      print('username' + username);
      // Only call success callback after all data is properly stored
      onSuccessfulAuth();
    } on AuthException catch (error) {
      print('Auth Exception: ${error.message}');
      rethrow; // Rethrow to handle in UI
    } catch (error) {
      print('Unexpected error: ${error.toString()}');
      rethrow; // Rethrow to handle in UI
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw Exception('Sign-up failed - no user created');
      }

      final localData = LocalData();
      await localData.storeEmail(email: email);
    } catch (error) {
      print('Error during sign up: ${error.toString()}');
      rethrow;
    }
  }

  Future<void> signOut() async {
    final data = LocalData();
    await supabase.auth.signOut();
    await data.deleteUserData();
  }
}

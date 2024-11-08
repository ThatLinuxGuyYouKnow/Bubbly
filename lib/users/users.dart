import 'package:supabase_flutter/supabase_flutter.dart';

class Users {
  final supabase = Supabase.instance.client;

  // Get all usernames from the 'users' table
  Future<List<String>> getAllUsers() async {
    try {
      final response = await supabase.from('users').select('username');

      // Extract and return the list of usernames
      return List<String>.from(response.map((user) => user['username']));
    } catch (e) {
      print('An error occurred: $e');
      return [];
    }
  }

  // Get users matching a specific username pattern
  Future<List<String>> getUsersByMatch(
      {required String steppedUsername}) async {
    try {
      final response = await supabase
          .from('users')
          .select('username')
          .ilike('username', '%$steppedUsername%');

      // Extract and return the list of usernames
      return List<String>.from(response.map((user) => user['username']));
    } catch (e) {
      print('An error occurred: $e');
      return [];
    }
  }
}

import 'package:bubbly/data/localHandling/localData.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseData {
  final _supabase = Supabase.instance.client;
  final _localData = LocalData();

  Future<void> registerNewUsername({
    required String username,
    required String email,
  }) async {
    try {
      await _supabase.from('users').upsert({
        'username': username.trim(),
        'email': email.trim(),
      }).select();

      _localData.storeEmail(email: email);
      _localData.storeUsername(username: username);
    } catch (e) {
      throw Exception('Failed to register username: $e');
    }
  }

  Future<String?> getUsernameFromEmail({required String email}) async {
    try {
      final data = await _supabase
          .from('users')
          .select('username')
          .eq('email', email.trim())
          .maybeSingle();

      return data?['username'] as String?;
    } catch (e) {
      throw Exception('Failed to get username: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getConversations({
    required String currentUsername,
  }) async {
    try {
      final data = await _supabase.rpc('get_latest_conversations',
          params: {'user_username': currentUsername}).select();

      return List<Map<String, dynamic>>.from(data as List);
    } catch (e) {
      throw Exception('Failed to get conversations: $e');
    }
  }
}

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
      print('conversations fetched with username' + currentUsername);
      final data = await _supabase.rpc('get_latest_conversations',
          params: {'user_username': currentUsername}).select();

      return List<Map<String, dynamic>>.from(data as List);
    } catch (e) {
      print(e);
      throw Exception('Failed to get conversations: $e');
    }
  }

  Future<void> addChat({
    required String senderUsername,
    required String senderEmail,
    required String receiverUsername,
    required String messageContent,
  }) async {
    try {
      // Step 1: Get the receiver's email from the 'users' table
      final receiverData = await _supabase
          .from('users')
          .select('email')
          .eq('username', receiverUsername)
          .single();

      // Check if the receiver's email was found
      if (receiverData == null || receiverData['email'] == null) {
        throw Exception('Receiver email not found');
      }
      final receiverEmail = receiverData['email'];

      // Step 2: Insert the new chat message into the 'chats' table
      final chatData = {
        'sender_username': senderUsername,
        'sender_email': senderEmail,
        'receiver_username': receiverUsername,
        'receiver_email': receiverEmail,
        'message_content': messageContent,
        'created_at': DateTime.now().toIso8601String(),
      };

      await _supabase.from('chats').insert(chatData);
    } catch (e) {
      throw Exception('Failed to add chat: $e');
    }
  }
}

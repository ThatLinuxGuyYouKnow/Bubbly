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
      print('conversations fetched with username' + currentUsername.toString());
      final data = await _supabase.rpc('get_latest_conversations',
          params: {'user_username': currentUsername.toString()}).select();

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

  Stream<List<Map<String, dynamic>>> messageStream({
    required String currentUsername,
    required String recipientUsername,
  }) {
    try {
      // Using `inFilter` to match either sender or receiver for the given usernames
      return _supabase
          .from('chats')
          .stream(primaryKey: ['id'])
          .inFilter('sender_username', [currentUsername, recipientUsername])
          .order('created_at', ascending: true)
          .map((list) =>
              list.map((item) => item as Map<String, dynamic>).toList());
    } catch (e) {
      print('Error fetching message stream: $e');
      throw Exception('Failed to get message stream: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getConversationMessages({
    required String currentUsername,
    required String recipientUsername,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final data = await _supabase
          .from('chats')
          .select()
          .or('and(sender_username.eq.$currentUsername,receiver_username.eq.$recipientUsername),and(sender_username.eq.$recipientUsername,receiver_username.eq.$currentUsername)')
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      throw Exception('Failed to get messages: $e');
    }
  }
}

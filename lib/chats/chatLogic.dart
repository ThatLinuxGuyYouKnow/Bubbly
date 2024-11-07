import 'package:supabase_flutter/supabase_flutter.dart';

class Chat {
  Future<void> addChat({
    required String senderUsername,
    required String senderEmail,
    required String receiverUsername,
    required String messageContent,
  }) async {
    final supabase = Supabase.instance.client;
    String? receiverEmail;

    // Step 1: Fetch receiver's email from the users table
    try {
      final response = await supabase
          .from('users')
          .select('email')
          .eq('username', receiverUsername)
          .single();

      // Assign the fetched email to receiverEmail
      receiverEmail = response['email'];
    } on PostgrestException catch (error) {
      print('Error fetching receiver email: ${error.message}');
      return; // Exit if there's an error fetching the email
    }

    // Check if receiverEmail is still null
    if (receiverEmail == null) {
      print('Receiver email not found');
      return;
    }

    // Step 2: Insert the chat entry into chats table
    final insertResponse = await supabase.from('chats').insert({
      'sender_username': senderUsername,
      'sender_email': senderEmail,
      'receiver_username': receiverUsername,
      'receiver_email': receiverEmail,
      'message_content': messageContent,
    });

    if (insertResponse.error != null) {
      print('Error adding chat: ${insertResponse.error!.message}');
    } else {
      print('Chat added successfully!');
    }
  }
}

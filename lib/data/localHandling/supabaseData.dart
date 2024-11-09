import 'package:bubbly/data/localHandling/localData.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseData {
  registerNewUsername({required String username, required String email}) async {
    final supabase = Supabase.instance.client;
    print('email to supabase' + email);
    print('username to supbase' + username);
    final data = await supabase
        .from('users')
        .upsert({'username': username, 'email': email}).select();
    final localdata = LocalData();
    localdata.storeEmail(email: email);
    localdata.storeUsername(username: username);
  }

  Future<String?> getUsernameFromEmail({required String email}) async {
    final supabase = Supabase.instance.client;
    final data = await supabase
        .from('users')
        .select('username') // Select the username column
        .eq('email', email) // Match the email field
        .maybeSingle(); // Use maybeSingle to get a single result or null if none

    if (data != null && data['username'] != null) {
      return data['username'] as String;
    }
    return null;
  }
}
//
//testtttd
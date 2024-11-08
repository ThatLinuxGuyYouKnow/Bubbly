import 'package:bubbly/data/localHandling/localData.dart';
import 'package:flutter/material.dart';
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
}
//
//testtttd
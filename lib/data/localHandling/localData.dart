import 'package:get_storage/get_storage.dart';

class LocalData {
  storeEmail({required String email}) {
    final box = GetStorage('user-data');
    box.write('user-email', email);
  }

  storeUsername({required String username}) {
    final box = GetStorage('user-data');
    box.write('username', username);
  }

  String getUsername() {
    final box = GetStorage('user-data');
    String username = box.read('username') ?? '';
    return username;
  }

  String getUserEmail() {
    final box = GetStorage('user-data');
    String username = box.read('user-email') ?? '';
    return username;
  }

  deleteUserData() {
    final box = GetStorage('user-data');
    box.erase();
  }
}

import 'package:get_storage/get_storage.dart';

class localData {
  storeEmail({required String email}) {
    final box = GetStorage();
    box.write('user-email', email);
  }

  storeUsername({required String username}) {
    final box = GetStorage();
    box.write('username', username);
  }
}

import 'package:get_storage/get_storage.dart';

class LocalData {
  Future<void> storeEmail({required String email}) async {
    try {
      await GetStorage.init('user-data'); // Initialize before using
      final box = GetStorage('user-data');
      await box.write('user-email', email);
    } catch (error) {
      print('Failed to store email: ${error.toString()}');
      rethrow;
    }
  }

  Future<void> storeUsername({required String username}) async {
    try {
      await GetStorage.init('user-data'); // Initialize before using
      final box = GetStorage('user-data');
      await box.write('username', username);
    } catch (error) {
      print('Failed to store username: ${error.toString()}');
      rethrow;
    }
  }

  String? getUsername() {
    try {
      final box = GetStorage('user-data');
      return box.read('username');
    } catch (error) {
      print('Failed to get username: ${error.toString()}');
      return null;
    }
  }

  String? getUserEmail() {
    try {
      final box = GetStorage('user-data');
      return box.read('user-email');
    } catch (error) {
      print('Failed to get email: ${error.toString()}');
      return null;
    }
  }

  Future<void> deleteUserData() async {
    try {
      final box = GetStorage('user-data');
      await box.erase();
    } catch (error) {
      print('Failed to delete user data: ${error.toString()}');
      rethrow;
    }
  }
}

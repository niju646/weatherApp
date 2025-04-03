import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService{
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

Future<void> storeLoginData(Map<String, dynamic> loginResponse) async {
  await secureStorage.write(key: 'accessToken', value: loginResponse['accessToken']);
  await secureStorage.write(key: 'refreshToken', value: loginResponse['refreshToken']);
  await secureStorage.write(key: 'email', value: loginResponse['email']);
}

Future<Map<String, String?>> getStoredLoginData() async {
  String? accessToken = await secureStorage.read(key: 'accessToken');
  String? refreshToken = await secureStorage.read(key: 'refreshToken');
  String? email = await secureStorage.read(key: 'email');

  return {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'email': email,
  };
}

Future<bool> isLoggedIn() async {
  String? accessToken = await secureStorage.read(key: 'accessToken');
  return accessToken != null; // User is logged in if accessToken exists
}

Future<void> logout() async {
  await secureStorage.deleteAll();
}


}
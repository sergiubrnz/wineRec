import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wine_rec/utils/strings.dart';

class SecureStorage {
  static const storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  static Future<void> setKeepMeAuthenticated(bool value) async {
    await storage.write(
      key: kIsLoggedInFlag,
      value: value.toString(),
    );
  }

  static Future<String?> getKeepMeAuthenticated() async {
    return await storage.read(
      key: kIsLoggedInFlag,
    );
  }

  static Future<void> setUserName(String value) async {
    await storage.write(
      key: kUserName,
      value: value,
    );
  }

  static Future<String?> getUserName() async {
    return await storage.read(
      key: kUserName,
    );
  }

  static Future<void> setEmail(String value) async {
    await storage.write(
      key: kEmail,
      value: value,
    );
  }

  static Future<String?> getEmail() async {
    return await storage.read(
      key: kEmail,
    );
  }

  static Future<void> setUID(String value) async {
    await storage.write(
      key: kUID,
      value: value,
    );
  }

  static Future<String?> getUID() async {
    return await storage.read(
      key: kUID,
    );
  }

  static Future<void> setUserImage(String value) async {
    await storage.write(
      key: kUserImage,
      value: value,
    );
  }

  static Future<String?> getUserImage() async {
    return await storage.read(
      key: kUserImage,
    );
  }

  static Future<void> deleteAllData() async {
    await storage.deleteAll();
  }
}

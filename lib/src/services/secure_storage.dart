import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  Future<void> saveLocalData({
    required String key,
    required String value,
  }) async {
    await storage.write(
      key: key,
      value: value,
    );
  }

  FutureOr<String?> readLocalData({
    required String key,
  }) async {
    return await storage.read(
      key: key,
    );
  }

  Future<void> deleteLocalData({
    required String key,
  }) async {
    await storage.delete(
      key: key,
    );
  }
}

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/pick_image.dart';

class UserMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUserInfo({
    required String uid,
  }) async {
    String res = "Some error occurred";

    try {
      if (uid.isNotEmpty) {
        var response = await _firestore.collection('users').doc(uid).get();
        await response;
        res = "success";

        return response.data();
      } else {
        res = "Please enter all the fields";
        return null;
      }
    } catch (err) {
      res = err.toString();
      print(res);
      return null;
    }
  }

  Future<String> updateUserName({
    required String uid,
    required String username,
  }) async {
    String res = "Some error occurred";

    try {
      if (username.isNotEmpty) {
        await _firestore.collection('users').doc(uid).update({
          'nume': username,
        });

        res = "success";
      }
    } catch (err) {
      print(err);
      res = err.toString();
    }
    return res;
  }

  Future<String> updateUserSurname({
    required String uid,
    required String surname,
  }) async {
    String res = "Some error occurred";

    try {
      if (surname.isNotEmpty) {
        await _firestore.collection('users').doc(uid).update({
          'prenume': surname,
        });

        res = "success";
      }
    } catch (err) {
      print(err);
      res = err.toString();
    }
    return res;
  }

  Future<String> updateUserImage({
    required String uid,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";

    try {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage('profilePics', file, false);

      await _firestore.collection('users').doc(uid).update({
        'photoUrl': photoUrl,
      });

      res = "success";
    } catch (err) {
      print(err);
      res = err.toString();
    }
    return res;
  }
}

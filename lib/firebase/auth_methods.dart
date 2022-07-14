import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wine_rec/utils/Storage/user_preferences.dart';

import '../utils/pick_image.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String surname,
    required Uint8List file,
    required List wineSorts,
  }) async {
    String res = "A avut loc o eroare. Te rog incearca mai tarziu!";
    try {
      if (email.isNotEmpty ||
              password.isNotEmpty ||
              username.isNotEmpty ||
              surname.isNotEmpty
          //|| file != null
          ) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        await _firestore.collection('users').doc(cred.user!.uid).set({
          'nume': username,
          'prenume': surname,
          'uid': cred.user!.uid,
          'email': email,
          'collections': [],
          'likes': [],
          'photoUrl': photoUrl,
          'lovedSorts': [],
        });
        print(wineSorts);

        await _firestore.collection('users').doc(cred.user!.uid).update(
          {
            "lovedSorts": FieldValue.arrayUnion(wineSorts),
          },
        );

        res = "success";
      } else {
        res = "Te rugam sa completezi toate campurile!";
      }
    } catch (err) {
      print(err);
      res = err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        var response = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        await _firestore
            .collection('users')
            .doc(response.user?.uid)
            .get()
            .then((value) async => {
                  print(value.data().toString()),
                  await SecureStorage.setEmail(
                      value.data()!['email'].toString()),
                  await SecureStorage.setUserName(
                      value.data()!['prenume'].toString()),
                  await SecureStorage.setUID(value.data()!['uid'].toString()),
                  await SecureStorage.setUserImage(
                      value.data()!['photoUrl'].toString()),
                });

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}

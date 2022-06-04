import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wine_rec/utils/Storage/user_preferences.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String surname,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
              password.isNotEmpty ||
              username.isNotEmpty ||
              surname.isNotEmpty
          // || file != null
          ) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        print(cred.user!.uid);

        await _firestore.collection('users').doc(cred.user!.uid).set({
          'nume': username,
          'prenume': surname,
          'uid': cred.user!.uid,
          'email': email,
          'collections': [],
          'likes': [],
        });

        res = "success";
      }
    } catch (err) {
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
                  await SecureStorage.setUID(
                    value.data()!['uid'].toString(),
                  ),
                });
        final email1 = await SecureStorage.getEmail();
        print(email1);
        print(response);

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

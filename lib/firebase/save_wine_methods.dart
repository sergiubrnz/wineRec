import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../utils/Storage/user_preferences.dart';

class SaveWineMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> SaveWine({
    required String denumire,
    required int year,
    required String tip,
    required String culoare,
    required double pret,
    required String sort,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (denumire.isNotEmpty ||
          year.isFinite ||
          tip.isNotEmpty ||
          sort.isNotEmpty ||
          culoare.isNotEmpty ||
          pret.isFinite) {
        var photo = await FirebaseStorage.instance
            .ref()
            .child('/winePics/${DateTime.now().millisecondsSinceEpoch}');

        final uploadTask = photo.putData(file);
        final snapshot = await uploadTask.whenComplete(() => {});
        final photoUrl = await snapshot.ref.getDownloadURL();

        final userID = await SecureStorage.getUID();

        var wineId = await _firestore.collection('wines').add({
          'denumire': denumire,
          'year': year,
          'tip': tip,
          'culoare': culoare,
          'pret': pret,
          'sort': sort,
          'photoUrl': photoUrl,
        });

        await _firestore.collection('users').doc(userID).update(
          {
            "collections": FieldValue.arrayUnion([wineId]),
          },
        );
        res = "success";
      }
    } catch (err) {
      print(err);
      res = err.toString();
    }
    return res;
  }

  Future<String> SaveWineToFavourites({
    required String id,
  }) async {
    String res = "Some error occurred";
    try {
      if (id.isNotEmpty) {
        final userID = await SecureStorage.getUID();

        var wineId = await _firestore.doc(id).get();

        await _firestore.collection('users').doc(userID).update(
          {
            "likes": FieldValue.arrayUnion([wineId.reference]),
          },
        );
        res = "success";
      }
    } catch (err) {
      print(err);
      res = err.toString();
    }
    return res;
  }

  Future<String> SaveNewWineToFavourites({
    required String denumire,
    required int year,
    required String tip,
    required String culoare,
    required double pret,
    required String sort,
    required String photoUrl,
  }) async {
    String res = "Some error occurred";
    try {
      final userID = await SecureStorage.getUID();

      var wineId = await _firestore.collection('wines').add({
        'denumire': denumire,
        'year': year,
        'tip': tip,
        'culoare': culoare,
        'pret': pret,
        'sort': sort,
        'photoUrl': photoUrl,
      });

      await _firestore.collection('users').doc(userID).update(
        {
          "likes": FieldValue.arrayUnion([wineId]),
        },
      );
      res = "success";
    } catch (err) {
      print(err);
      res = err.toString();
    }
    return res;
  }
}

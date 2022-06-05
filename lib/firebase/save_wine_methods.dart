import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/Storage/user_preferences.dart';
import '../utils/pick_image.dart';

class SaveWineMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign up user
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
        String photoUrl = await StorageMethods()
            .uploadImageToStorage('winePics', file, false);

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
}

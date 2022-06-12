import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../utils/Storage/user_preferences.dart';

class DeleteWineMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> DeleteWine({
    required String id,
    required String photoUrl,
  }) async {
    String res = "Some error occurred";
    try {
      var wineId = await _firestore.collection('wines').doc(id).delete();

      var image = await FirebaseStorage.instance.refFromURL(photoUrl).delete();

      res = "success";
    } catch (err) {
      print(err);
      res = err.toString();
    }
    return res;
  }

  Future<String> DeleteWineFromCollection({
    required String id,
  }) async {
    String res = "Some error occurred";
    try {
      if (id.isNotEmpty) {
        final userID = await SecureStorage.getUID();

        var wineId = await _firestore.collection('wines').doc(id);

        print('ID: ${wineId}');

        await _firestore.collection('users').doc(userID).update(
          {
            "collections": FieldValue.arrayRemove([wineId]),
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

  Future<String> DeleteWineFromLikes({
    required String id,
  }) async {
    String res = "Some error occurred";
    try {
      if (id.isNotEmpty) {
        final userID = await SecureStorage.getUID();

        var wineId = await _firestore.collection('wines').doc(id);

        print('ID: ${wineId}');

        await _firestore.collection('users').doc(userID).update(
          {
            "likes": FieldValue.arrayRemove([wineId]),
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

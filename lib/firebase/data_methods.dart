import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/Models/wineModel.dart';

class DataMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<WineModel>?> getLikes({
    required String uid,
  }) async {
    String res = "Some error occurred";

    List<WineModel> wineList = <WineModel>[];

    try {
      if (uid.isNotEmpty) {
        WineModel wine;
        List refList;

        var response = await _firestore
            .collection('users')
            .doc(uid)
            .get()
            .then((value) async => {
                  refList = await List.from(value.data()!['likes']),
                  for (DocumentReference ref in refList)
                    {
                      await ref.get().then(
                            (value) async => {
                              wine = WineModel.fromSnapshot(value),
                              wineList.add(wine),
                            },
                          ),
                    },
                  print(wineList.length),
                });
        await response;
        res = "success";

        return wineList;
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

  Future<List<WineModel>?> getCollection({
    required String uid,
  }) async {
    String res = "Some error occurred";

    List<WineModel> wineList = <WineModel>[];

    try {
      if (uid.isNotEmpty) {
        WineModel wine;
        List refList;

        var response = await _firestore
            .collection('users')
            .doc(uid)
            .get()
            .then((value) async => {
                  refList = await List.from(value.data()!['collections']),
                  for (DocumentReference ref in refList)
                    {
                      await ref.get().then(
                            (value) async => {
                              wine = WineModel.fromSnapshot(value),
                              wineList.add(wine),
                            },
                          ),
                    },
                  print(wineList.length),
                });
        await response;
        res = "success";

        return wineList;
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
}

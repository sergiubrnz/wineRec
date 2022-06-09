import 'package:cloud_firestore/cloud_firestore.dart';

class WineModel {
  String denumire;
  int year;
  String tip;
  String culoare;
  String photoUrl;
  double pret;
  String sort;
  String id;

  Map<String, dynamic> toJson() {
    return {
      'denumire': denumire,
      'year': year,
      'tip': tip,
      'culoare': culoare,
      'pret': pret,
      'sort': sort,
      'photoUrl': photoUrl,
      'id': id,
    };
  }

  WineModel.fromSnapshot(DocumentSnapshot snapshot)
      : denumire = snapshot['denumire'],
        year = snapshot['year'],
        tip = snapshot['tip'],
        culoare = snapshot['culoare'],
        pret = snapshot['pret'],
        sort = snapshot['sort'],
        photoUrl = snapshot['photoUrl'],
        id = snapshot.id;
}

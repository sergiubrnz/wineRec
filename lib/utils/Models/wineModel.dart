import 'package:cloud_firestore/cloud_firestore.dart';

class WineModel {
  String name;
  int year;
  String type;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'year': year,
      'type': type,
    };
  }

  WineModel.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot['name'],
        year = snapshot['year'],
        type = snapshot['type'];
}

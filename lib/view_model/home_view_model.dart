import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/place_model.dart';

class HomeViewModel extends ChangeNotifier {
  final CollectionReference _placesRef = FirebaseFirestore.instance.collection(
    'places',
  );

  Stream<List<Place>> get placesStream {
    return _placesRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Place.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}

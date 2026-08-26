import 'package:PlaceFinderApp/model/place_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

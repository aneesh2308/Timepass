import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kingslayer1/models/days.dart';

class FirestoreService2 {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveDay(Day day){
    return _db.collection('day').doc(day.productId).set(day.toMap2());
  }

  Stream<List<Day>> getDays(){
    return _db.collection('day').snapshots().map((snapshot) => snapshot.docs.map((document) => Day.fromFirestore2(document.data())).toList());
  }

  Future<void> removeDay(String productId){
    return _db.collection('day').doc(productId).delete();
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:kingslayer1/models/time.dart';

class FirestoreService1 {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveProduct(Time time){
    return _db.collection('times').doc(time.productId).set(time.toMap1());
  }

  Stream<List<Time>> getTimes(){
    return _db.collection('times').snapshots().map((snapshot) => snapshot.docs.map((document) => Time.fromFirestore1(document.data())).toList());
  }

  Future<void> removeProduct(String productId){
    return _db.collection('times').doc(productId).delete();
  }
}
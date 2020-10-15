import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kingslayer1/models/approval.dart';

class FirestoreService3{
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveApproval(Approved approve){
    return _db.collection('Approved').doc(approve.productId).set(approve.toMap());
  }

  Stream<List<Approved>> getApprovals(){
    return _db.collection('Approved').snapshots().map((snapshot) => snapshot.docs.map((document) => Approved.fromFirestore3(document.data())).toList());
  }

  Future<void> removeApproval(String productId){
    return _db.collection('Approved').doc(productId).delete();
  }
}
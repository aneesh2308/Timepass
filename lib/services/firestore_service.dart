import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kingslayer1/models/product.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveProduct(Product product){
    return _db.collection('products').doc(product.productId).set(product.toMap());
  }

  // Future<void> breakTime(Product product){
  //   return _db.collection('products').doc(product.productId).set(product.time());
  // }

  Stream<List<Product>> getProducts(){
    return _db.collection('products').snapshots().map((snapshot) => snapshot.docs.map((document) => Product.fromFirestore(document.data())).toList());
  }

  // List<Product> getProduct(){
  //   List<Product> myProducts=List();
  //   _db.collection("products").get().then((querySnapshot) {
  //     querySnapshot.docs.forEach((result) {
  //       print(result.data);
  //       myProducts.add(Product.fromFirestore(result.data()));
  //     });
  //   });
  //   return myProducts;
  // }

  // List<Product> getProduct(){
  //   List<Product> myProducts=List();
  //   _db.collection("products").get().then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((result) {
  //       print(result.data);
  //       myProducts.add(Product.fromFirestore(result.data()));
  //     });
  //   });
  //   return myProducts;
  // }
  //
  // Future<QuerySnapshot> readData(String productId) async {
  //   DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('products').doc(productId).get();
  //   print(snapshot.data()['time']);
  // }
  //
  // Stream<List> readinfo(){
  //   return _db.collection('products').snapshots().map((snapshot) => snapshot.docs.map((document) => Product().toMap()).toList());
  // }
  // Widget loadTimers(){
  //   return StreamBuilder(
  //     stream: FirebaseFirestore.instance.collection('products').snapshots(),
  //     builder: (context,snapshot){
  //       if (!snapshot.hasData) return Text('Time is Loading');
  //       for(int i = 0;i<snapshot.data.documents.length;i++){
  //         return snapshot.data.documents['products']['time']['startHour'];
  //       }
  //       return Text('Data is not Working');
  //     },
  //   );
  // }

  Future<void> removeProduct(String productId){
    return _db.collection('products').doc(productId).delete();
  }
}


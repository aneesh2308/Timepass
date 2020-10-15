import 'package:kingslayer1/models/approval.dart';
import 'package:kingslayer1/models/time.dart';
import 'package:kingslayer1/services/firestore_service1.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:kingslayer1/models/product.dart';

class TimeProvider with ChangeNotifier {
  final firestoreService1 = FirestoreService1();
  String _fromHour;
  String _fromMinute;
  String _toHour ;
  String _toMinute;
  String _productId;
  var uuid = Uuid();

  //Getters
  String get fromHour => _fromHour;
  String get fromMinute => _fromMinute;
  String get toHour => _toHour;
  String get toMinute => _toMinute;
  String get product => _productId;
  //Setters
  changeFromHour(String value) {
    _fromHour = value;
    notifyListeners();
  }

  changeFromMinute(String value) {
    _fromMinute = value;
    notifyListeners();
  }

  changeToHour(String value) {
    _toHour = value;
    notifyListeners();
  }

  changeToMinute(String value) {
    _toMinute = value;
    notifyListeners();
  }

  changeProductId(String value) {
    _productId = value;
    notifyListeners();
  }

  loadValues(Time time){
    _fromHour=time.fromHour;
    _fromMinute=time.fromMinute;
    _toHour=time.toHour;
    _toMinute=time.toMinute;
    _productId=time.productId;
  }


  saveBreak() {
    print(_productId);
    if (_productId == null) {
      var newTime = Time(fromHour:fromHour, fromMinute:fromMinute,toHour:toHour,toMinute: toMinute,productId: Approved().productId);
      firestoreService1.saveProduct(newTime);
    } else {
      //Update
      var updatedProduct =
      Time(fromHour: fromHour, fromMinute: _fromMinute, productId: _productId,toHour:_toHour,toMinute: _toMinute);
      firestoreService1.saveProduct(updatedProduct);
    }
  }

  removeBreak(String productId){
    firestoreService1.removeProduct(productId);
  }

}


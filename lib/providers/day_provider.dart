import 'package:kingslayer1/models/approval.dart';
import 'package:kingslayer1/models/days.dart';
import 'package:kingslayer1/services/firestore_service2.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DayProvider with ChangeNotifier {
  final firestoreService = FirestoreService2();
  String _productId;
  String _monday;
  String _tuesday;
  String _wednesday ;
  String _thursday;
  String _friday;
  String _saturday;
  String _sunday;
  String _forall;

  var uuid = Uuid();

  //Getters
  String get monday => _monday;
  String get tuesday => _tuesday;
  String get wednesday => _wednesday;
  String get thursday => _thursday;
  String get friday => _friday;
  String get saturday => _saturday;
  String get sunday => _sunday;
  String get forall => _forall;
  String get product => _productId;
  //Setters
  changeMonday(String value) {
    _monday = value;
    notifyListeners();
  }

  changeTuesday(String value) {
    _tuesday = value;
    notifyListeners();
  }

  changeWednesday(String value) {
    _wednesday = value;
    notifyListeners();
  }

  changeThursday(String value) {
    _thursday = value;
    notifyListeners();
  }

  changeFriday(String value) {
    _friday = value;
    notifyListeners();
  }

  changeSaturday(String value) {
    _saturday = value;
    notifyListeners();
  }

  changeSunday(String value) {
    _sunday = value;
    notifyListeners();
  }
  changeProductId(String value) {
    _productId = value;
    notifyListeners();
  }

  changeForAll(String value) {
    _forall = value;
    notifyListeners();
  }


  loadValues(Day day){
    _monday=day.monday;
    _tuesday=day.tuesday;
    _wednesday=day.wednesday;
    _thursday=day.thursday;
    _friday=day.friday;
    _saturday=day.saturday;
    _sunday=day.sunday;
    _forall=day.forall;
    _productId=day.productId;
  }

  saveDay() {
    print(_productId);
    if (_productId == null) {
      var newDay = Day(monday: monday, tuesday: tuesday, productId: Approved().productId,wednesday:wednesday,thursday:thursday, friday: friday,saturday:saturday, sunday: sunday,forall:forall);
      firestoreService.saveDay(newDay);
    } else {
      //Update
      var updatedDay =
      Day(monday: monday, tuesday: _tuesday,productId: _productId,wednesday:_wednesday,thursday:_thursday, friday:_friday,saturday:_saturday, sunday:_sunday,forall:_forall);
      firestoreService.saveDay(updatedDay);
    }
  }

  removeProduct(String productId){
    firestoreService.removeDay(productId);
  }

}
import 'package:kingslayer1/models/approval.dart';
import 'package:kingslayer1/services/firestore_service3.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ApprovalProvider with ChangeNotifier {
  final firestoreService = FirestoreService3();
  String _email;
  String _approved;
  String _productId;
  String _licenseNumber;

  var uuid = Uuid();

  //Getters
  String get email => _email;
  String get approved => _approved;
  String get product => _productId;
  String get licenseNumber => _licenseNumber;

  //Setters
  changeEmail(String value) {
    _email = value;
    notifyListeners();
  }

  changeApproval(String value) {
    _approved=value;
    notifyListeners();
  }

  changeLicenseNumber(String value) {
    _licenseNumber = value;
    notifyListeners();
  }

  changeProductId(String value){
    _productId = value;
    notifyListeners();
  }

   loadValues(Approved approve){
     _email=approve.email;
     _approved=approve.approved;
    _productId=approve.productId;
     _licenseNumber=approve.licenseNumber;
  }

  saveApproval() {
    print(_productId);
    if (_productId == null) {
      var newApproved = Approved(email: email, approved: approved,productId: uuid.v4(),licenseNumber:licenseNumber);
      firestoreService.saveApproval(newApproved);
    } else {
      //Update
      var updatedApproved =
      Approved(email: email, approved: _approved, productId: _productId,licenseNumber:_licenseNumber);
      firestoreService.saveApproval(updatedApproved);
    }
  }



  removeApproval(String productId){
    firestoreService.removeApproval(productId);
  }

}
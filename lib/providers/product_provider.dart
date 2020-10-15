import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kingslayer1/models/approval.dart';
import 'package:kingslayer1/models/product.dart';
import 'package:kingslayer1/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _name;
  double _experience;
  String _productId;
  String _url;
  int _startHour;
  int _startMin;
  int _endHour;
  int _endMin;
  double _fees;
  String _field;
  String _intro;
  String _languages;
  int _type;
  double _rating;
  Map _time;
  List _timer;

  var uuid = Uuid();

  //Getters
  String get name => _name;
  double get experience => _experience;
  String get product => _productId;
  String get url => _url;
  int get startHour => _startHour;
  int get startMin => _startMin;
  int get endHour => _endHour;
  int get endMin => _endMin;
  double get fees => _fees;
  String get field => _field;
  String get intro => _intro;
  String get languages => _languages;
  double get rating => _rating;
  int get type => _type;
  Map get time => _time;
  List get timer => _timer;

  //Setters
  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changePrice(String value) {
    _experience = double.parse(value);
    notifyListeners();
  }

  changePhoto(String value) {
    _url = value;
    notifyListeners();
  }

  changeStartHour(String value) {
    _startHour = int.parse(value);
    notifyListeners();
  }

  changeTime(Map<String,dynamic> value) {
    _time = value;
    notifyListeners();
  }

  changeStartMinute(String value) {
    _startMin = int.parse(value);
    notifyListeners();
  }

  changeEndHour(String value) {
    _endHour = int.parse(value);
    notifyListeners();
  }

  changeEndMinute(String value) {
    _endMin = int.parse(value);
    notifyListeners();
  }

  changeFees(String value) {
    _fees= double.parse(value);
    notifyListeners();
  }

  changeRating(String value) {
    _rating= double.parse(value);
    notifyListeners();
  }

  changeField(String value) {
    _field = value;
    notifyListeners();
  }

  changeIntro(String value) {
    _intro = value;
    notifyListeners();
  }

  changeUrl(String value) {
    _url = value;
    notifyListeners();
  }

  changeLanguage(String value) {
    _languages = value;
    notifyListeners();
  }

  changeType(String value) {
    _type = int.parse(value);
    notifyListeners();
  }

  changeProductId(String value){
    _productId = value;
    notifyListeners();
  }

  loadValues(Product product){
    _name=product.name;
    _experience=product.experience;
    _productId=product.productId;
    _url=product.url;
    _field=product.field;
    _fees=product.fees;
    _languages=product.languages;
    _type=product.type;
    _time = product.time();
    _rating = product.rating;
    _intro = product.intro;
    _time['startHour']=product.time()['startHour'];
    _time['startMin']=product.time()['startMin'];
    _time['endHour']=product.time()['endHour'];
    _time['endMin']=product.time()['endMin'];
  }

  saveProduct() {
    print(_productId);
    if (_productId == null) {
      var newProduct = Product(name: name, experience: experience,productId: Approved().productId,url:url,startHour:startHour, startMin:startMin,endHour:endHour, endMin:endMin,field:field, fees: fees ,intro: intro, rating: rating,languages:languages, type:type);
      firestoreService.saveProduct(newProduct);
    } else {
      //Update
      var updatedProduct =
      Product(name: name, experience: _experience, productId: _productId,url:_url,startHour: _startHour, startMin:_startMin,endHour: _endHour, endMin: _endMin,field: _field, fees: _fees ,intro: _intro, rating: _rating,languages: _languages, type: _type);
      firestoreService.saveProduct(updatedProduct);
    }
  }

  addTimer(Product product) {
    _timer.insert(0, _startHour);
    notifyListeners();
  }

  removeProduct(String productId){
    firestoreService.removeProduct(productId);
  }

}

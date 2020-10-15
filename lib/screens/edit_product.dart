import 'package:kingslayer1/models/approval.dart';
import 'package:kingslayer1/models/days.dart';
import 'package:kingslayer1/models/product.dart';
import 'package:flutter/material.dart';
import 'package:kingslayer1/providers/approval_provider.dart';
import 'package:kingslayer1/providers/day_provider.dart';
import 'package:kingslayer1/screens/times.dart';
import 'package:kingslayer1/services/firestore_service.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
class EditProduct extends StatefulWidget {
  final Product Doctor;
  final Day Doctor1;
  final Approved Doctor2;
  EditProduct([this.Doctor,this.Doctor1,this.Doctor2]);
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final feesController = TextEditingController();
  final fieldController = TextEditingController();
  final introController = TextEditingController();
  final typeController = TextEditingController();
  final languageController = TextEditingController();
  final ratingController = TextEditingController();
  final urlController = TextEditingController();
  final deleteController = TextEditingController();
  final startHourController = TextEditingController();
  final startMinController = TextEditingController();
  final endHourController = TextEditingController();
  final endMinController = TextEditingController();
  double rating;
  bool value_1 = false;
  bool value_2=false;
  bool value_3=false;
  bool value_4=false;
  bool value_5=false;
  bool value_6=false;
  bool value_7=false;
  bool value_8=false;
  bool value_9=false;
  bool value_10=false;
  bool value_11=false;
  bool value_12=true;
  List<int> _currencies = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
  ];
  List<int> _time = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59,
  ];
  List<int> _currencies1 = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
  ];
  List<int> _time1 = [
     0,
     1,
     2,
     3,
     4,
     5,
     6,
     7,
     8,
     9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59,
  ];
  var _currentItemSelected= 0;
  var _currentItemSelected1=0;
  var _currentItemSelected2=0;
  var _currentItemSelected3=0;
  var _value_2 = "false";
  var _value_3 = "false";
  var _value_4 = "false";
  var _value_5 = "false";
  var _value_6 = "false";
  var _value_7 = "false";
  var _value_8 = "false";
  var _value_9 = "false";
  var _value_10 = "false";
  String url1 = "https://www.marshall.edu/cam/files/unknown.gif";
  Future getImage() async {
    // Get image from gallery.
    showDialog(
      context: context,
      child: AlertDialog(
        content:Text("Please click ok once photo updates",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight:FontWeight.bold,
          ),
        ),
        actions: [
          FlatButton(
              child: const Text('Okay',style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                fontWeight:FontWeight.bold,
              )),
              color: Colors.blue,
              onPressed: () {
                Navigator.pop(context);
              }
          )
        ],
      ),
    );
    PickedFile image = await ImagePicker().getImage(source: ImageSource.gallery);
    File selected = File(image.path);
    _uploadImageToFirebase(selected);
  }
  Future<void> _uploadImageToFirebase(File image) async {
    try {
      // Make random image name.
      String imageLocation = 'images/image${nameController.text}.jpg';

      // Upload image to firebase.
      final StorageReference storageReference = FirebaseStorage().ref().child(imageLocation);
      final StorageUploadTask uploadTask = storageReference.putFile(image);
      await uploadTask.onComplete;
      _addPathToDatabase(imageLocation);
    }catch(e){
      print(e.message);
    }
  }
  Future<void> _addPathToDatabase(String text) async {
    {
      // Get image URL from firebase
      final ref = FirebaseStorage().ref().child(text);
      var imageString = await ref.getDownloadURL();
      setState(() {
        (() {
          if(value_10==true){
            return value_10=false;}
          else{return value_10=true;}
        })();
      });
      // Add location and url to database
      urlController.text=imageString;
      url1=imageString;
    }}
  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    urlController.dispose();
    feesController.dispose();
    fieldController.dispose();
    introController.dispose();
    typeController.dispose();
    languageController.dispose();
    ratingController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    if (widget.Doctor == null) {
      //New Record
      nameController.text = "";
      priceController.text = "";
      urlController.text = url1;
      feesController.text = "";
      fieldController.text = "";
      introController.text = "";
      typeController.text = "";
      languageController.text = "";
      ratingController.text = "";
      _currentItemSelected= 0;
      _currentItemSelected1=0;
      _currentItemSelected2=0;
      _currentItemSelected3=0;
      _value_2 = 'true';

      new Future.delayed(Duration.zero,() {
        final productProvider = Provider.of<ProductProvider>(context,listen: false);
        productProvider.loadValues(Product());
        productProvider.changePhoto(url1);
      });
      new Future.delayed(Duration.zero,() {
        final dayProvider = Provider.of<DayProvider>(context,listen: false);
        dayProvider.loadValues(Day());
      });
    } else {
      //Controller Update
      nameController.text=widget.Doctor.name;
      priceController.text=widget.Doctor.experience.toString();
      urlController.text = widget.Doctor.url.toString();
      feesController.text = widget.Doctor.fees.toString();
      fieldController.text = widget.Doctor.field;
      introController.text = widget.Doctor.intro;
      typeController.text = widget.Doctor.type.toString();
      languageController.text = widget.Doctor.languages;
      ratingController.text = widget.Doctor.rating.toString();
      _currentItemSelected  = widget.Doctor.time()['startHour'];
      _currentItemSelected1 = widget.Doctor.time()['startMin'];
      _currentItemSelected2 = widget.Doctor.time()['endHour'];
      _currentItemSelected3 = widget.Doctor.time()['endMin'];

      //State Update
      new Future.delayed(Duration.zero, () {
        final productProvider = Provider.of<ProductProvider>(context,listen: false);
        productProvider.loadValues(widget.Doctor);
      });
    }
    if (widget.Doctor1 == null) {
      //New Record
      _value_2 = 'true';
      new Future.delayed(Duration.zero,() {
        final dayProvider = Provider.of<DayProvider>(context,listen: false);
        dayProvider.loadValues(Day());
      });
    } else {
      //Controller Update
      _value_2 = widget.Doctor1.monday;
      //State Update
      new Future.delayed(Duration.zero, () {
        final dayProvider = Provider.of<DayProvider>(context,listen: false);
        dayProvider.loadValues(widget.Doctor1);
      });

    }
    super.initState();
  }
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final dayProvider = Provider.of<DayProvider>(context);
    final approvalProvider = Provider.of<ApprovalProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Edit Product'),backgroundColor:Colors.red),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: [
                Row(
                  children: [
                    Text("Verification of the Doctor",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight:FontWeight.bold,
                    ),
                    ),
                    Switch(
                      value:value_12,
                      onChanged: (value){
                        setState(() {
                          (() {
                            if(value_12==true){
                              return value_12=false;}
                            else{return value_12=true;}
                          })();
                          _value_10 = value_1.toString();
                          print(_value_10);
                          (() {
                            if(_value_10=="false"){
                              return approvalProvider.changeApproval(_value_10);}
                            else{return null;}
                          })();
                          approvalProvider.changeProductId(widget.Doctor.productId);
                          approvalProvider.changeEmail(widget.Doctor2.email);
                          approvalProvider.changeLicenseNumber(widget.Doctor2.licenseNumber);
                          approvalProvider.saveApproval();
                        });
                        return showDialog(
                          context: context,
                          child: AlertDialog(
                            content:Text("By Clicking This Button,the doctor will no longer be verified",
                              style: TextStyle(
                              fontSize: 15.0,
                              fontWeight:FontWeight.bold,
                            ),
                            ),
                          ),
                        );
                      },
                      inactiveTrackColor: Colors.grey,
                      activeColor: Colors.blue,
                      activeTrackColor:Colors.blue[600],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("To Add or Edit Details press button",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight:FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value:value_1,
                      onChanged: (value){
                        setState(() {
                          (() {
                            if(value_1==true){
                              return value_1=false;}
                            else{return value_1=true;}
                          })();
                        });
                        return showDialog(
                          context: context,
                          child: AlertDialog(
                            content:Text("By Clicking This Button,Doctor Goes Back to Evaluation Mode",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight:FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                      inactiveTrackColor: Colors.grey,
                      activeColor: Colors.blue,
                      activeTrackColor:Colors.blue[600],
                    ),
                  ],
                ),
                CircleAvatar(
                  key:productProvider.changePhoto(urlController.text),
                  child: InkWell(

                    onTap:getImage
                  ),
                  backgroundImage: NetworkImage(urlController.text),
                  radius: 55.0,
                ),
                Row(
                  children: [
                    Text("Type of Doctor  ",style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(typeController.text,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
            Text('Doctor Name',style:TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              enabled: value_1,
              controller: nameController,
              decoration: InputDecoration(hintText: 'Doctor Name'),
              onChanged: (value) {
                productProvider.changeName(value);
              },
              autofocus: true,
            ),
            Text('Doctor Practiced for',style:TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              keyboardType: TextInputType.number,
              enabled: value_1,
              controller: priceController,
              decoration: InputDecoration(hintText: 'Doctor Practiced for'),
              onChanged: (value) => productProvider.changePrice(value),
              autofocus: true,
            ),
                Text('Doctor Field',style:TextStyle(fontWeight: FontWeight.bold)),
                TextField(
                  enabled: value_1,
                  controller: fieldController,
                  decoration: InputDecoration(hintText: 'Doctor Field'),
                  onChanged: (value) {
                    productProvider.changeField(value);
                    (() {
                      if(fieldController.text=="Physician"||fieldController.text=="physician"||fieldController.text=="PHYSICIAN"){
                        return typeController.text="0";}
                      else{return typeController.text="";}
                    })();
                    (() {
                      if(fieldController.text=="Psychologist"||fieldController.text=="psychologist"||fieldController.text=="PSYCHOLOGIST"){
                        return typeController.text="1";}
                      else{return typeController.text=="";}
                    })();
                    (() {
                      if(fieldController.text=="Pediatrician"||fieldController.text=="pediatrician"||fieldController.text=="PEDIATRICIAN"){
                        return typeController.text="2";}
                      else{return typeController.text=="";}
                    })();
                    (() {
                      if(fieldController.text=="Psychiatrist"||fieldController.text=="psychiatrist"||fieldController.text=="PSYCHIATRIST"){
                        return typeController.text="3";}
                      else{return typeController.text=="";}
                    })();
                    (() {
                      if(fieldController.text=="Dietitian"||fieldController.text=="dietitian"||fieldController.text=="DIETITIAN"){
                        return typeController.text="4";}
                      else{return typeController.text=="";}
                    })();
                    (() {
                      if(fieldController.text=="Dermatologist"||fieldController.text=="dermatologist"||fieldController.text=="DERMATOLOGIST"){
                        return typeController.text="5";}
                      else{return typeController.text=="";}
                    })();
                    (() {
                      if(fieldController.text=="Genetic"||fieldController.text=="genetic"||fieldController.text=="GENETIC"){
                        return typeController.text="6";}
                      else{return typeController.text=="";}
                    })();
                    (() {
                      if(fieldController.text=="Yoga"||fieldController.text=="yoga"||fieldController.text=="YOGA"){
                        return typeController.text="7";}
                      else{return typeController.text=="";}
                    })();
                    productProvider.changeType(typeController.text);
                  },
                  autofocus: true,
                ),
                Text('Doctor languages',style:TextStyle(fontWeight: FontWeight.bold)),
                TextField(
                  enabled: value_1,
                  controller: languageController,
                  decoration: InputDecoration(hintText: 'Doctor languages'),
                  onChanged: (value) {
                    // (() {
                    //   if(value_1==true){
                    //     return showDialog(
                    //       context: context,
                    //       child: AlertDialog(
                    //         content:Text("Please write languages in language|language|language",
                    //           style: TextStyle(
                    //             fontSize: 15.0,
                    //             fontWeight:FontWeight.bold,
                    //           ),
                    //         ),
                    //         actions: [
                    //           FlatButton(
                    //               child: const Text('Okay',style: TextStyle(
                    //                 fontSize: 15.0,
                    //                 color: Colors.white,
                    //                 fontWeight:FontWeight.bold,
                    //               )),
                    //               color: Colors.blue,
                    //               onPressed: () {
                    //                 Navigator.pop(context);
                    //               }
                    //           )
                    //         ],
                    //       ),
                    //     );}
                    //   else{return null;}
                    // })();
                    productProvider.changeLanguage(value);
                  },
                  autofocus: true,
                ),
                Text('Doctor Intro',style:TextStyle(fontWeight: FontWeight.bold)),
                TextField(
                  enabled: value_1,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: introController,
                  decoration: InputDecoration(hintText: 'Doctor Intro'),
                  onChanged: (value) {
                    productProvider.changeIntro(value);
                    // productProvider.getProduct(Product().name);
                  },
                  autofocus: true,
                ),
                Text('Doctor Fees',style:TextStyle(fontWeight: FontWeight.bold)),
                TextField(
                  keyboardType: TextInputType.number,
                  enabled: value_1,
                  controller: feesController,
                  decoration: InputDecoration(hintText: 'Doctor Fees'),
                  onChanged: (value) {
                    productProvider.changeFees(value);
                  },
                  autofocus: true,
                ),
                Text('Doctor Rating',style:TextStyle(fontWeight: FontWeight.bold)),
                TextField(
                  keyboardType: TextInputType.number,
                  enabled: value_1,
                  controller: ratingController,
                  decoration: InputDecoration(hintText: 'Doctor Rating'),
                  onChanged: (value) {
                    rating = double.parse(ratingController.text);
                    setState(() {
                      (() {
                        if((rating>=0)){
                          return
                            (() {
                              if((rating>5.0)){
                                return
                                  showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      content:Text("Please keep the rating between 0-5",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight:FontWeight.bold,
                                        ),
                                      ),
                                      actions: [
                                        FlatButton(
                                            child: const Text('Okay',style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                              fontWeight:FontWeight.bold,
                                            )),
                                            color: Colors.blue,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }
                                        )
                                      ],
                                    ),
                                  );
                              }
                              else{return productProvider.changeRating(value);}
                            })();}
                        else{return showDialog(
                          context: context,
                          child: AlertDialog(
                            content:Text("Please keep the rating between 0-5",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight:FontWeight.bold,
                              ),
                            ),
                            actions: [
                              FlatButton(
                                  child: const Text('Okay',style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    fontWeight:FontWeight.bold,
                                  )),
                                  color: Colors.blue,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }
                              )
                            ],
                          ),
                        );}
                      })();
                    });
                  },
                  autofocus: true,
                ),

             SizedBox(
                  height: 20.0,
             ),
              Text("The Days Doctor is Available"),
              Column(
                mainAxisAlignment:MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                          value: true,
                          groupValue: value_2,
                          onChanged: (_value_2){
                            setState(() {
                              (() {
                                if(_value_2=="true"){
                                  return value_2=true;}
                                else{return value_2=false;}
                              })();
                              (() {
                                if(value_2==true){
                                  return value_2=false;}
                                else{return value_2=true;}
                              })();
                                (() {
                                  if(_value_2=="true"){
                                    return _value_2="false";}
                                  else{return _value_2="true";}
                                })();
                            });
                            dayProvider.changeMonday(_value_2);
                            dayProvider.changeProductId(widget.Doctor.productId);
                          },
                          activeColor: Colors.blue,
                          toggleable:true,
                      ),
                      Text(
                        'Monday',
                        style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                      ),
                      Radio(
                        value: true,
                        groupValue: value_3,
                        onChanged: (value){
                          setState(() {
                            (() {
                              if(value_3==true){
                                return value_3=false;}
                              else{return value_3=true;}
                            })();
                          });
                          dayProvider.changeTuesday(value_3.toString());
                          dayProvider.changeProductId(widget.Doctor.productId);
                        },
                        activeColor: Colors.blue,
                        toggleable:true,
                      ),
                      Text("Tuesday",style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)),
                      Radio(
                        value: true,
                        groupValue: value_4,
                        onChanged: (value){
                          setState(() {
                            (() {
                              if(value_4==true){
                                return value_4=false;}
                              else{return value_4=true;}
                            })();
                          });
                          dayProvider.changeWednesday(value);
                          dayProvider.changeProductId(widget.Doctor.productId);
                        },
                        activeColor: Colors.blue,
                        toggleable:true,
                      ),

                      Text("Wednesday",style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: true,
                        groupValue: value_5,
                        onChanged: (value){
                          setState(() {
                            (() {
                              if(value_5==true){
                                return value_5=false;}
                              else{return value_5=true;}
                            })();
                          });
                          dayProvider.changeThursday(value);
                          dayProvider.changeProductId(widget.Doctor.productId);
                        },
                        activeColor: Colors.blue,
                        toggleable:true,
                      ),
                      Text(
                        'Thursday',
                        style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                      ),
                      Radio(
                        value: true,
                        groupValue: value_6,
                        onChanged: (value){
                          setState(() {
                            (() {
                              if(value_6==true){
                                return value_6=false;}
                              else{return value_6=true;}
                            })();
                          });
                          dayProvider.changeFriday(value);
                          dayProvider.changeProductId(widget.Doctor.productId);
                        },
                        activeColor: Colors.blue,
                        toggleable:true,
                      ),
                      Text("Friday",style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)),
                      Radio(
                        value: true,
                        groupValue: value_7,
                        onChanged: (value){
                          setState(() {
                            (() {
                              if(value_7==true){
                                return value_7=false;}
                              else{return value_7=true;}
                            })();
                          });
                          dayProvider.changeSaturday(value);
                          dayProvider.changeProductId(widget.Doctor.productId);
                        },
                        activeColor: Colors.blue,
                        toggleable:true,
                      ),
                      Text("Saturday",style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: true,
                        groupValue: value_8,
                        onChanged: (value){
                          setState(() {
                            (() {
                              if(value_8==true){
                                return value_8=false;}
                              else{return value_8=true;}
                            })();
                          });
                          dayProvider.changeSunday(value);
                          dayProvider.changeProductId(widget.Doctor.productId);
                        },
                        activeColor: Colors.blue,
                        toggleable:true,
                      ),
                      Text(
                        'Sunday',
                        style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                      ),
                      Radio(
                        value: true,
                        groupValue: value_9,
                        onChanged: (value){
                          setState(() {
                            (() {
                              if(value_9==true){
                                return value_9=false;}
                              else{return value_9=true;}
                            })();
                          });
                          dayProvider.changeForAll(value);
                          dayProvider.changeProductId(widget.Doctor.productId);
                        },
                        activeColor: Colors.blue,
                        toggleable:true,
                      ),
                      Text("All Days",style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Break from"),
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      decoration:BoxDecoration(
                        borderRadius:BorderRadius.circular(5.0),
                        color: Colors.black,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          items: _currencies.map((int dropDownStringItem) {
                            return DropdownMenuItem<int>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem.toString(),style: TextStyle(color: Colors.white),),
                            );
                          }).toList(),
                          onChanged: (int newValueSelected) {
                            // Your code to execute, when a menu item is selected from drop down
                            _onDropDownItemSelected(newValueSelected);
                            productProvider.changeStartHour(newValueSelected.toString());
                            // print(productProvider.);
                          },
                          dropdownColor: Colors.black,
                          value:_currentItemSelected,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      decoration:BoxDecoration(
                        borderRadius:BorderRadius.circular(10.0),
                        color: Colors.black,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          items: _time.map((int dropDownStringItem) {
                            return DropdownMenuItem<int>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem.toString(),style: TextStyle(color: Colors.white),),
                            );
                          }).toList(),
                          onChanged: (int newValueSelected1) {
                            // Your code to execute, when a menu item is selected from drop down
                            _onDropDownItemSelected1(newValueSelected1);
                            productProvider.changeStartMinute(newValueSelected1.toString());
                          },
                          dropdownColor: Colors.black,
                          value:_currentItemSelected1,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  children: [
                    Text("Break till"),
                    SizedBox(
                      width: 35.0,
                    ),
                    Container(
                      decoration:BoxDecoration(
                        borderRadius:BorderRadius.circular(5.0),
                        color: Colors.black,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          items: _currencies1.map((int dropDownStringItem) {
                            return DropdownMenuItem<int>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem.toString(),style: TextStyle(color: Colors.white),),
                            );
                          }).toList(),
                          onChanged: (int newValueSelected2) {
                            // Your code to execute, when a menu item is selected from drop down
                            _onDropDownItemSelected2(newValueSelected2);
                            productProvider.changeEndHour(newValueSelected2.toString());
                          },
                          dropdownColor: Colors.black,
                          value:_currentItemSelected2,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      decoration:BoxDecoration(
                        borderRadius:BorderRadius.circular(10.0),
                        color: Colors.black,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          items: _time1.map((int dropDownStringItem) {
                            return DropdownMenuItem<int>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem.toString(),style: TextStyle(color: Colors.white),),
                            );
                          }).toList(),
                          onChanged: (int newValueSelected3) {
                            // Your code to execute, when a menu item is selected from drop down
                            _onDropDownItemSelected3(newValueSelected3);
                            productProvider.changeEndMinute(newValueSelected3.toString());
                          },
                          dropdownColor: Colors.black,
                          value:_currentItemSelected3,
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 10.0),
                (widget.Doctor !=null)?
              Row(
                children: [
                  Text("Number of Breaks taken by Doctor"),
                  SizedBox(width: 5.0),
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Times()));
                    },
                    textColor: Colors.white,
                    child:Text("Add a Break"),
                    color: Colors.red[400],
                  ),
                ],
              ):Container(),
              SizedBox(height: 10.0),
              RaisedButton(
              child: Text('Save'),
                textColor: Colors.white,
              onPressed: () {
                productProvider.saveProduct();
                dayProvider.saveDay();
                Navigator.of(context).pop();
              },
                color: Colors.blue,
            ),
            (widget.Doctor !=null) ? RaisedButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text('Delete'),
              onPressed: _showDialog,
            ): Container(),
          ],
        ),
       ]
      ),
      ),
    );
  }
  _showDialog() async {
    await showDialog<String>(
      context: context,
      child:new AlertDialog(
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                controller:deleteController,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Enter "Delete" to Confirm Delete', hintText: 'eg. Delete'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('Delete'),
              color: Colors.red,
              onPressed: ()
              {
                  setState(() {
                    (() {
                      if(deleteController.text=="Delete"||deleteController.text=="delete"||deleteController.text=="DELETE"){
                        return _delete();
                      }
                      else{return Navigator.pop(context);}
                    })();
                  });
              })
        ],
      ),
    );
  }
  void _approval(){
  final approvalProvider =Provider.of<ApprovalProvider>(context, listen: false);
  approvalProvider.changeEmail(widget.Doctor2.email);
  approvalProvider.changeLicenseNumber(widget.Doctor2.licenseNumber);
  }
  void _delete(){
    final productProvider =Provider.of<ProductProvider>(context, listen: false);
    productProvider.firestoreService.removeProduct(widget.Doctor.productId);
    Navigator.pushReplacementNamed(context, '/homepage');
  }
  void _onDropDownItemSelected(int newValueSelected) {
    setState(() {
      this._currentItemSelected= newValueSelected;
    });
  }
  void _onDropDownItemSelected1(int newValueSelected1) {
    setState(() {
      this._currentItemSelected1 = newValueSelected1;
    });
  }
  void _onDropDownItemSelected2(int newValueSelected2) {
    setState(() {
      this._currentItemSelected2 = newValueSelected2;

    });
  }
  void _onDropDownItemSelected3(int newValueSelected3) {
    setState(() {
      this._currentItemSelected3 = newValueSelected3;
    });
  }
}

class Record {
  final String location;
  final String url;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['location'] != null),
        assert(map['url'] != null),
        location = map['location'],
        url = map['url'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$location:$url>";
}

// productProvider.removeProduct(widget.Doctor.productId);
// Navigator.of(context).pop();

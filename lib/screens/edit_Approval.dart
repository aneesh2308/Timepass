import 'package:kingslayer1/models/approval.dart';
import 'package:kingslayer1/models/days.dart';
import 'package:kingslayer1/models/product.dart';
import 'package:flutter/material.dart';
import 'package:kingslayer1/models/time.dart';
import 'package:kingslayer1/providers/day_provider.dart';
import 'package:kingslayer1/providers/time_provider.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kingslayer1/providers/approval_provider.dart';
class EditApproval extends StatefulWidget {
  final Approved Doctor;
  EditApproval([this.Doctor]);
  @override
  _EditApprovalState createState() => _EditApprovalState();
}

class _EditApprovalState extends State<EditApproval> {
  final nameController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final deleteController = TextEditingController();
  bool value_1 = false;
  bool value_2 = true;
  var _value_3 = "false";
  @override
  void dispose() {
    nameController.dispose();
    licenseNumberController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    if (widget.Doctor == null) {
      //New Record
      nameController.text = "";
      licenseNumberController.text = "";
      _value_3 = "false";
      new Future.delayed(Duration.zero,() {
        final productProvider = Provider.of<ProductProvider>(context,listen: false);
        final timeProvider = Provider.of<TimeProvider>(context,listen: false);
        final dayProvider = Provider.of<DayProvider>(context,listen: false);
        timeProvider.loadValues(Time());
        dayProvider.loadValues(Day());
        productProvider.loadValues(Product());
      });}
    else {
      //Controller Update
      _value_3=widget.Doctor.approved;
      licenseNumberController.text = widget.Doctor.licenseNumber;
      //State Update
      new Future.delayed(Duration.zero, () {
        final approvalProvider = Provider.of<ApprovalProvider>(context,listen: false);
        approvalProvider.loadValues(widget.Doctor);
      });
    }
    super.initState();
  }
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final approvalProvider = Provider.of<ApprovalProvider>(context);
    final timeProvider = Provider.of<TimeProvider>(context);
    final dayProvider = Provider.of<DayProvider>(context);
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
                            _value_3 = value_1.toString();
                            print(_value_3);
                            approvalProvider.changeApproval(_value_3);
                          });
                          return showDialog(
                            context: context,
                            child: AlertDialog(
                              content:Text("By Clicking This Button,you have approved this doctor",
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
                  TextField(
                    enabled: value_1,
                    controller: nameController,
                    decoration: InputDecoration(hintText: 'Doctor Name'),
                    onChanged: (value) {
                      productProvider.changeName(value);
                      productProvider.changePrice("0");
                      productProvider.changeFees("0");
                      productProvider.changeField("");
                      productProvider.changeIntro("");
                      productProvider.changeLanguage("");
                      productProvider.changeRating("5");
                      productProvider.changeStartHour("00");
                      productProvider.changeStartMinute("00");
                      productProvider.changeEndHour("00");
                      productProvider.changeEndMinute("00");
                      timeProvider.changeFromHour("00");
                      timeProvider.changeFromMinute("00");
                      timeProvider.changeToHour("00");
                      timeProvider.changeToMinute("00");
                      dayProvider.changeSunday("false");
                      dayProvider.changeMonday("false");
                      dayProvider.changeTuesday("false");
                      dayProvider.changeWednesday("false");
                      dayProvider.changeThursday("false");
                      dayProvider.changeFriday("false");
                      dayProvider.changeSaturday("false");
                      dayProvider.changeForAll("false");
                      timeProvider.changeProductId(widget.Doctor.productId);
                      dayProvider.changeProductId(widget.Doctor.productId);
                      productProvider.changeProductId(widget.Doctor.productId);
                      productProvider.changeUrl("https://www.marshall.edu/cam/files/unknown.gif");
                    },
                    autofocus: true,
                  ),
                  TextField(
                    enabled: value_1,
                    controller: licenseNumberController,
                    decoration: InputDecoration(hintText: 'Doctor license number'),
                    onChanged: (value) {
                      approvalProvider.changeLicenseNumber(value);
                    },
                    autofocus: true,
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    child: Text('Save'),
                    onPressed: () {
                      productProvider.saveProduct();
                      dayProvider.saveDay();
                      timeProvider.saveBreak();
                      approvalProvider.saveApproval();
                      Navigator.of(context).pop();
                    },
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
  void _page(){
    Navigator.pushReplacementNamed(context, 'Approval');
    Navigator.of(context).pop();
  }
  void _delete(){
    final approvalProvider =Provider.of<ApprovalProvider>(context, listen: false);
    approvalProvider.firestoreService.removeApproval(widget.Doctor.productId);
    Navigator.pushReplacementNamed(context, 'Approval');
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
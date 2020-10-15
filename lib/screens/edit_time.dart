import 'package:kingslayer1/models/product.dart';
import 'package:kingslayer1/models/time.dart';
import 'package:flutter/material.dart';
import 'package:kingslayer1/providers/time_provider.dart';
import 'package:provider/provider.dart';
import '../providers/time_provider.dart';

class EditTime extends StatefulWidget {
  final Time breakTaker;
  EditTime([this.breakTaker]);
  @override
  _EditTimeState createState() => _EditTimeState();
}

class _EditTimeState extends State<EditTime> {
  List<String> _currencies = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
  ];
  List<String> _time = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59',
    '60',
  ];
  List<String> _currencies1 = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
  ];
  List<String> _time1 = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59',
  ];
  var _currentItemSelected= '00';
  var _currentItemSelected1='00';
  var _currentItemSelected2='00';
  var _currentItemSelected3='00';
  @override
  void initState() {
    if (widget.breakTaker == null) {
      //New Record
      new Future.delayed(Duration.zero,() {
        final timeProvider = Provider.of<TimeProvider>(context,listen: false);
        timeProvider.loadValues(Time());
      });
    } else {
      //Controller Update
      _currentItemSelected=widget.breakTaker.fromHour;
      _currentItemSelected1=widget.breakTaker.fromMinute;
      _currentItemSelected2= widget.breakTaker.toHour;
      _currentItemSelected3= widget.breakTaker.toMinute;
      //State Update
      new Future.delayed(Duration.zero, () {
        final timeProvider = Provider.of<TimeProvider>(context,listen: false);
        timeProvider.loadValues(widget.breakTaker);
      });
    }
    super.initState();
  }
  Widget build(BuildContext context) {
    final timeProvider = Provider.of<TimeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Break Time Setter'),backgroundColor:Colors.red),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
            children: [
              Column(
                children:<Widget>[
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
                          child: DropdownButton<String>(
                            items: _currencies.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem,style: TextStyle(color: Colors.white),),
                              );
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              // Your code to execute, when a menu item is selected from drop down
                              _onDropDownItemSelected(newValueSelected);
                              timeProvider.changeFromHour(newValueSelected);
                            },
                            dropdownColor: Colors.black,
                            value:_currentItemSelected ,
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
                          child: DropdownButton<String>(
                            items: _time.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem,style: TextStyle(color: Colors.white),),
                              );
                            }).toList(),
                            onChanged: (String newValueSelected1) {
                              // Your code to execute, when a menu item is selected from drop down
                              _onDropDownItemSelected1(newValueSelected1);
                              timeProvider.changeFromMinute(newValueSelected1);
                            },
                            dropdownColor: Colors.black,
                            value:_currentItemSelected1 ,
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
                          child: DropdownButton<String>(
                            items: _currencies1.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem,style: TextStyle(color: Colors.white),),
                              );
                            }).toList(),
                            onChanged: (String newValueSelected2) {
                              // Your code to execute, when a menu item is selected from drop down
                              _onDropDownItemSelected2(newValueSelected2);
                              timeProvider.changeToHour(newValueSelected2);

                            },
                            dropdownColor: Colors.black,
                            value: _currentItemSelected2,
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
                          child: DropdownButton<String>(
                            items: _time1.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem,style: TextStyle(color: Colors.white),),
                              );
                            }).toList(),
                            onChanged: (String newValueSelected3) {
                              // Your code to execute, when a menu item is selected from drop down
                              _onDropDownItemSelected3(newValueSelected3);
                              timeProvider.changeToMinute(newValueSelected3);
                            },
                            dropdownColor: Colors.black,
                            value: _currentItemSelected3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    child: Text('Save'),
                    onPressed: () {
                      timeProvider.saveBreak();
                      Navigator.of(context).pop();
                    },
                  ),
                  (widget.breakTaker !=null) ? RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text('Delete'),
                    onPressed: (){
                      timeProvider.removeBreak(widget.breakTaker.productId);
                      Navigator.of(context).pop();
                    },
                  ): Container(),
                ],
              ),
            ],
        ),
      ),
    );
  }
  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }
  void _onDropDownItemSelected1(String newValueSelected1) {
    setState(() {
      this._currentItemSelected1 = newValueSelected1;
    });
  }
  void _onDropDownItemSelected2(String newValueSelected2) {
    setState(() {
      this._currentItemSelected2 = newValueSelected2;
    });
  }
  void _onDropDownItemSelected3(String newValueSelected3) {
    setState(() {
      this._currentItemSelected3 = newValueSelected3;
    });
  }
}
// productProvider.removeProduct(widget.Doctor.productId);
// Navigator.of(context).pop();
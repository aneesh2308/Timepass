import 'package:kingslayer1/models/time.dart';
import 'package:flutter/material.dart';
import 'package:kingslayer1/screens/edit_time.dart';
import 'package:provider/provider.dart';

class Times extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final times = Provider.of<List<Time>>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Doctors'),
          centerTitle: true,
          backgroundColor:Colors.red,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditTime()));
              },
            ),
          ],
        ),
        body: (times != null)
            ? ListView.builder(
            itemCount: times.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(8.0),

                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditTime(times[index])));
                  },
                  child: Container(
                    constraints: BoxConstraints.expand(
                      width: 200.0,
                      height: 70.0,
                    ),
                    decoration:BoxDecoration(
                      color:Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width:15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children:<Widget>[
                                Text("Break from: ",style: TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: 10.0),
                                Text(times[index].fromHour,style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(" : ",style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(times[index].fromMinute,style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              children:<Widget>[
                                SizedBox(width:15.0),
                                Text("Break to: ",style: TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: 10.0),
                                Text(times[index].toHour,style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(" : ",style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(times[index].toMinute,style: TextStyle(fontWeight: FontWeight.bold)),
                               ],
                         ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
            : Center(child: CircularProgressIndicator()));
  }
}

// Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProduct(products[index])));
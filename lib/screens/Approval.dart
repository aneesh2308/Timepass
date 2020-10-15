import 'package:kingslayer1/models/product.dart';
import 'package:kingslayer1/screens/edit_Approval.dart';
import 'package:flutter/material.dart';
import 'package:kingslayer1/service/authservice.dart';
import 'package:provider/provider.dart';
import '../models/approval.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Approvals extends StatelessWidget {
  int _page = 0;
  @override
  Widget build(BuildContext context) {
    final approval = Provider.of<List<Approved>>(context);
    GlobalKey _bottomNavigationKey = GlobalKey();
    return Scaffold(
        bottomNavigationBar:CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 50.0,
            items:<Widget>[
              Icon(Icons.home, size: 30,color: Colors.white,),
              Icon(Icons.contacts, size: 30,color: Colors.white,),
            ],
            color: Colors.red,
            buttonBackgroundColor: Colors.red,
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (int i) {
              {
                _page = 0;
                    () {
                  if (i==0){
                    Navigator.popAndPushNamed(context,"Approval");
                  }
                  else{
                    Navigator.popAndPushNamed(context,"/homepage");
                  }
                }();
              }}
          //optional, default as 0
        ),
        appBar: AppBar(
          title: Text('Doctors Approval'),
          centerTitle: true,
          backgroundColor:Colors.red,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                size: 30.0,
              ),
              onPressed: () {
                AuthService().signOut();
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
        body: (approval != null )
            ? ListView.builder(
            itemCount: approval.length,
            itemBuilder: (context, index) {
              return
                (approval[index].approved == "false")?
                Padding(
                padding: EdgeInsets.all(8.0),

                child: InkWell(
                  onTap: (){
                    (() {
                      if(approval[index].approved == "false"){
                        return Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditApproval(approval[index])));
                      }
                      else{
                        return Container();
                      }
                    })();
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
                            Text(approval[index].email,style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(approval[index].approved.toString(),style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ):Container();
            })
            : Center(child: CircularProgressIndicator()));
  }
}

// Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProduct(products[index])));
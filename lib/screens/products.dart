import 'package:kingslayer1/models/approval.dart';
import 'package:kingslayer1/screens/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:kingslayer1/service/authservice.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class Products extends StatelessWidget {
  int _page = 0;
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context);
    final approval = Provider.of<List<Approved>>(context);
    return Scaffold(
        bottomNavigationBar:ConvexAppBar(
          items:[
            TabItem(icon:Icon(Icons.home,color: Colors.white,size: 30,),title:"",),
            TabItem(icon:Icon(Icons.contacts,color: Colors.white,size: 30,),title:""),
          ],
          initialActiveIndex: 1,
          onTap:(int i)=>((){
            if (i==0){
              Navigator.popAndPushNamed(context,"Approval");
            }
            else{
              Navigator.popAndPushNamed(context,"/homepage");
            }
          }()),
          style:TabStyle.reactCircle,
          activeColor:Colors.red,
          backgroundColor:Colors.red,
        ),
        appBar: AppBar(
          title: Text('Doctors'),
          centerTitle: true,
          backgroundColor:Colors.red,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProduct()));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                size: 30.0,
              ),
              onPressed: () {
                AuthService().signOut();
                Navigator.popAndPushNamed(context, '/login');

              },

            ),
          ],
        ),
        body: (products != null)
            ? ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProduct(products[index])));
                  },
                  child: Container(
                    constraints: BoxConstraints.expand(
                      width: 200.0,
                      height: 70.0,
                    ),
                    decoration:BoxDecoration(
                      color:Colors.white,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            child:InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProduct(products[index])));
                            },
                            ),
                            backgroundImage: NetworkImage(products[index].url),
                            radius: 25.0,
                          ),
                          SizedBox(width:15),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(products[index].name,style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(products[index].toMap().toString(),style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })
            : Center(child: CircularProgressIndicator()));
  }
}

// Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProduct(products[index])));
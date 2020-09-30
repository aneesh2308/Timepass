import 'package:kingslayer1/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart' as p;


class EditProduct extends StatefulWidget {
  final Product Doctor;
  EditProduct([this.Doctor]);
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  bool value_1 = false;
  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.Doctor == null) {
      //New Record
      nameController.text = "";
      priceController.text = "";
      new Future.delayed(Duration.zero,() {
        final productProvider = Provider.of<ProductProvider>(context,listen: false);
        productProvider.loadValues(Product());
      });
    } else {
      //Controller Update
      nameController.text=widget.Doctor.name;
      priceController.text=widget.Doctor.price.toString();
      //State Update
      new Future.delayed(Duration.zero, () {
        final productProvider = Provider.of<ProductProvider>(context,listen: false);
        productProvider.loadValues(widget.Doctor);
      });

    }

    super.initState();
  }
  File _image;
  @override
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }

  Future uploadPic(BuildContext context) async{
    String fileName = p.basename(_image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
    setState(() {
      print("Profile Picture uploaded");
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    });
  }
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: [
                Row(
                  children: [
                    Text("Press the Button if Doctor is Legit",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight:FontWeight.bold,
                    ),
                    ),
                    SizedBox(
                      width: 55.0,
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
                        AlertDialog(
                          title:Text("By Allowing this,the Doctor Will be Approved by your account",
                            style: TextStyle(
                            fontSize: 15.0,
                            fontWeight:FontWeight.bold,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Color(0xff476cfb),
                        child: ClipOval(
                          child: new SizedBox(
                            width: 180.0,
                            height: 180.0,
                            child: (_image!=null)?Image.file(
                              _image,
                              fit: BoxFit.fill,
                            ):Image.network(
                              "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
            TextField(
              enabled: value_1,
              controller: nameController,
              decoration: InputDecoration(hintText: 'Doctor Name'),
              onChanged: (value) {
                productProvider.changeName(value);
              },
              autofocus: true,
            ),
            TextField(
              keyboardType: TextInputType.number,
              enabled: value_1,
              controller: priceController,
              decoration: InputDecoration(hintText: 'Doctor Practiced for'),
              onChanged: (value) => productProvider.changePrice(value),
              autofocus: true,
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              child: Text('Save'),
              onPressed: () {
                productProvider.saveProduct();
                Navigator.of(context).pop();
              },
            ),
            (widget.Doctor !=null) ? RaisedButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text('Delete'),
              onPressed: () {
                productProvider.removeProduct(widget.Doctor.productId);
                Navigator.of(context).pop();
              },
            ): Container(),
          ],
        ),
       ]
      ),
      ),
    );
  }
}
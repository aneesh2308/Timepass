import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingslayer1/service/usermanagement.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email;
  String _password;
  bool see = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: "   Enter Email",
                    hintStyle: TextStyle(
                        color: Colors.white
                    ),
                    filled: true,
                    fillColor: Colors.grey[600],
                    border:OutlineInputBorder(
                        borderSide:BorderSide(color: Colors.black,width: 10.0,style:BorderStyle.solid ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0))
                    )
                ),
                onChanged: (val) {
                  setState(() {
                    _email = val;
                  });
                },
              ),
              SizedBox(height: 15.0),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(hintText: "   Enter Password",
                    hintStyle: TextStyle(
                        color: Colors.white
                    ),
                    suffixIcon:IconButton(onPressed:(){see==true ?see=false:see=true;},icon:Icon(Icons.remove_red_eye),color:see==false?Colors.blue:Colors.grey[800],),
                    filled: true,
                    fillColor: Colors.grey[600],
                    border:OutlineInputBorder(
                        borderSide:BorderSide(color: Colors.black,width: 10.0,style:BorderStyle.solid ),
                        borderRadius: BorderRadius.all(Radius.circular(50.0))
                    )
                ),
                onChanged: (val) {
                  setState(() {
                    _password = val;
                  });
                },
                obscureText: see,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child:Text('SignUp'),
                color: Colors.lightBlueAccent,
                textColor:Colors.white,
                elevation: 7.0,
                onPressed: (){
                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password).then((signedInUser){
                    UserManagement().storeNewUser(signedInUser,context);
                  }).catchError((e){print(e);});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


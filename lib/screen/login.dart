import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kingslayer1/service/usermanagement.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseUser user;
  String _email;
  String _password;
  GoogleSignIn googleAuth = GoogleSignIn();
  @override
  void initState(){
    super.initState();
    signOutGoogle();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network("http://www.nowcare4u.com/wp-content/uploads/2019/05/logf.png",fit:BoxFit.cover),
                  SizedBox(height:20.0),
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
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    child: Text("Login"),
                    onPressed: () {
                      FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password).then((UserCredential auth){
                        Navigator.pushReplacementNamed(context, 'Approval');
                      }).catchError((e){
                        showDialog(
                          context: context,
                          child: AlertDialog(
                            content:Container(
                              constraints: BoxConstraints.expand(
                                width: 100.0,
                                height: 80.0,
                              ),

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("INCORRECT INFORMATION!!!",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.red,
                                      fontWeight:FontWeight.bold,
                                    ),
                                  ),
                                  Text("Please check your password and emailid",
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      color: Colors.black,
                                      fontWeight:FontWeight.bold,
                                    ),
                                  ),
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
                            ),
                          ),
                        );
                        print(e);
                      });
                    },
                    elevation:7.0,
                    color: Colors.lightBlueAccent,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

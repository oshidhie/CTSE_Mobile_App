// ignore_for_file: file_names

import 'package:climatrix/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:climatrix/screens/Register.dart';
//ststeful widget to login
class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailInputController;
  late TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  // String emailValidator(String value) {
  //   String pattern =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regex = new RegExp(pattern);
  //   if (!regex.hasMatch(value)) {
  //     return 'Email format is invalid';
  //   } else {
  //     return value ;
  //   }
  // }

  // String pwdValidator(String value) {
  //   if (value.length < 8) {
  //     return 'Password must be longer than 8 characters';
  //   } else {
  //     return value;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Login"),
          backgroundColor: Colors.black,
          leading: Icon(Icons.login),
        ),
        body: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Colors.lightGreen, Colors.cyan])),
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
                width: 750,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
                      child: Image.asset(
                        '../web/img/logo.png',
                        // height: 120,
                        // width: 120,
                      ),
                    ),
                    SingleChildScrollView(
                        child: Form(
                      key: _loginFormKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                fillColor: Colors.white,
                                hintText: "Email",
                                contentPadding: EdgeInsets.all(16),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 3))),
                            controller: emailInputController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Colors.black,
                                ),
                                hintText: "Password",
                                contentPadding: EdgeInsets.all(16),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            controller: pwdInputController,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: 500,
                            height: 50,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black)),
                              child: Text("Login"),
                              onPressed: () {
                                if (_loginFormKey.currentState!.validate()) {
                                  FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: emailInputController.text,
                                          password: pwdInputController.text)
                                      .then((currentUser) => FirebaseFirestore
                                          .instance
                                          .collection("users")
                                          .doc(currentUser.user!.uid)
                                          .get()
                                          .then((DocumentSnapshot result) =>
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          // Blogs(currentUser.user)
                                                          HomePage(
                                                              currentUser.user)
                                                      // others(currentUser.user)
                                                      )))
                                          .catchError((err) => print(err)))
                                      .catchError((err) => print(err));
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text("Don't have an account yet?"),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: 500,
                            height: 50,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.black)),
                              child: Text("Register here!"),
                              onPressed: () {
                                //                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                                //   return LoginPage() ;)
                                // }
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return RegisterPage();
                                }));
                              },
                            ),
                          )
                        ],
                      ),
                    )),
                  ],
                ))));
  }
}

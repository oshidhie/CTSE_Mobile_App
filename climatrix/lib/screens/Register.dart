import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Blogs.dart';
import 'LoginPage.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  late TextEditingController firstNameInputController;
  late TextEditingController lastNameInputController;
  late TextEditingController emailInputController;
  late TextEditingController pwdInputController;
  late TextEditingController confirmPwdInputController;

  @override
  initState() {
    firstNameInputController = new TextEditingController();
    lastNameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    super.initState();
  }

  // String emailValidator(String value) {
  //   String pattern =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regex = new RegExp(pattern);
  //   if (!regex.hasMatch(value)) {
  //     return 'Email format is invalid';
  //   } else {
  //     return "no";
  //   }
  // }

  // String pwdValidator(String value) {
  //   if (value.length < 8) {
  //     return 'Password must be longer than 8 characters';
  //   } else {
  //     return "no";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
          leading: Icon(Icons.app_registration_rounded),
          backgroundColor: Colors.black,
        ),
        body: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Colors.lightGreen, Colors.cyan])),
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
                child: SingleChildScrollView(
                    child: Form(
              key: _registerFormKey,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsetsDirectional.all(16)),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_2),
                        hintText: "First Name",
                        contentPadding: EdgeInsets.all(16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    controller: firstNameInputController,
                    validator: (value) {
                      if (value == null) {
                        return "Please enter a valid first name.";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_2),
                          hintText: "Last name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                      controller: lastNameInputController,
                      validator: (value) {
                        if (value == null) {
                          return "Please enter a valid last name.";
                        }
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    controller: emailInputController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password, color: Colors.black),
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    controller: pwdInputController,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password, color: Colors.black),
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    controller: confirmPwdInputController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 500,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black)),
                      child: Text("Register"),
                      onPressed: () {
                        if (_registerFormKey.currentState!.validate()) {
                          if (pwdInputController.text ==
                              confirmPwdInputController.text) {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: emailInputController.text,
                                    password: pwdInputController.text)
                                .then((currentUser) => FirebaseFirestore
                                    .instance
                                    .collection("users")
                                    .doc(currentUser.user!.uid)
                                    .set({
                                      "uid": currentUser.user!.uid,
                                      "fname": firstNameInputController.text,
                                      "surname": lastNameInputController.text,
                                      "email": emailInputController.text,
                                    })
                                    .then((result) => {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Blogs(currentUser.user)),
                                              (_) => false),
                                          firstNameInputController.clear(),
                                          lastNameInputController.clear(),
                                          emailInputController.clear(),
                                          pwdInputController.clear(),
                                          confirmPwdInputController.clear()
                                        })
                                    .catchError((err) => print(err)))
                                .catchError((err) => print(err));
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text("The passwords do not match"),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.black)),
                                        child: Text("Close"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text("Already have an account?"),
                  const SizedBox(height: 16),
                  SizedBox(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black)),
                      child: Text("Login here!"),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                      },
                    ),
                    width: 500,
                    height: 50,
                  ),
                ],
              ),
            )))));
  }
}

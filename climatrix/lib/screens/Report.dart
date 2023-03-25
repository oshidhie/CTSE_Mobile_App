// ignore_for_file: file_names

import 'package:climatrix/screens/HomeScreen.dart';
import 'package:climatrix/screens/LoginPage.dart';
import 'package:climatrix/screens/all/AllReports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Reports extends StatefulWidget {
  final User? user;
  const Reports(this.user, {super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  var txt = TextEditingController();
  String vehicleNo = "";
  String location = "";
  String content = "";

  static User? get user => null;

  //Function to add tasks to the list
  createReports() {
    CollectionReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.user!.uid)
            .collection('Reports');
    Map<String, String> Reports = {
      'vehicleNo': vehicleNo,
      "location": location,
      'content': content
    };
    documentReference.add(Reports).whenComplete(() => print("input created"));
  }

  //function to delete items from the report list
  deletReports(item) {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user!.uid)
        .collection('Reports')
        .doc(item);

    documentReference.delete().whenComplete(() => print("report deleted"));
  }

  //function to update the status of a task by clicking on the check box
  updateReports(itemId, content) {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user!.uid)
        .collection('Reports')
        .doc(itemId);
    documentReference
        .update({'content': content}).whenComplete(() => print("Updated"));
  }

  int _selectedIndex = 2;

  homenavigation() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomePage(widget.user)));
  }

  allnavigation() {
     Navigator.push(context,
     MaterialPageRoute(builder: (context) => AllReports(widget.user)));
  }
  mynavigation() {
    //  Navigator.push(context,
    //  MaterialPageRoute(builder: (context) => HomePage(widget.user)));
  }
  addnavigation() {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            shadowColor: Colors.purple,

            content: Column(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: <Color>[Colors.lightGreen, Colors.cyan])),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    "Add Vehicle Details",
                    style: TextStyle(fontSize: 27, color: Colors.black),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Vehicle No = AKE-1234 / 12-1234',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: ((value) {
                      vehicleNo = value;
                    }),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Location of Incident',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: ((value) {
                      location = value;
                    }),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 10,
                    onChanged: ((value) {
                      content = value;
                    }),
                  ),
                ),
                // Container(
                //   child: TextField(onChanged: (value) {
                //     cstatus=value;
                //   },
                //     decoration: InputDecoration(labelText: 'Add Report'),),
                // )
              ],
            ),
            // content: TextField(onChanged: (value) {
            //   input=value;
            // },),
            // submit button
            actions: [
              Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.lightGreen)),
                          onPressed: () {
                            setState(() {
                              //add tasks
                              createReports();
                            });
                            //pop out dialog box after adding a task
                            Navigator.of(context).pop();
                          },
                          child: const Text("Add"))))
            ],
          );
        }));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        homenavigation();
      } else if (index == 1) {
        allnavigation();
      } else if (index == 2) {
        mynavigation();
      } else if (index == 3) {
        addnavigation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Icon(
          Icons.dashboard_customize,
        ),
        centerTitle: true,
        title: const Text('My Reports'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              }),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.user!.uid)
              .collection('Reports')
              .snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: ((context, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  return Card(
                      margin: EdgeInsets.all(16),
                      key: Key(index.toString()),
                      child: ListTile(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  content: Column(children: [
                                    SingleChildScrollView(
                                      child: IntrinsicHeight(
                                          child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            child: const Text(
                                              "View Reported Incident",
                                              style: TextStyle(
                                                  fontSize: 27,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(20),
                                                  alignment: Alignment.topLeft,
                                                  //height: 20,
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                            text:
                                                                documentSnapshot[
                                                                    'location']),
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            'Location of Incident',
                                                        border:
                                                            InputBorder.none),
                                                    maxLines: 1,
                                                    readOnly: true,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ))),

                                          Expanded(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(20),
                                                  alignment: Alignment.topLeft,
                                                  // height: 50,
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                            text: documentSnapshot[
                                                                'vehicleNo']),
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            'Vehicle No Reported',
                                                        border:
                                                            InputBorder.none),
                                                    maxLines: 1,
                                                    readOnly: true,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ))),

                                          // Container(
                                          //     child: Align(
                                          //         alignment: Alignment.topLeft,
                                          //         child: Text(
                                          //           documentSnapshot[
                                          //               'location'],
                                          //           style: TextStyle(
                                          //               color: Colors.black,
                                          //               fontSize: 30,
                                          //               fontWeight:
                                          //                   FontWeight.bold),
                                          //         ))),
                                          // Container(
                                          //     child: Align(
                                          //         alignment: Alignment.topLeft,
                                          //         child: Text(
                                          //           documentSnapshot[
                                          //               'vehicleNo'],
                                          //           style: TextStyle(
                                          //               color: Color.fromARGB(
                                          //                   255, 83, 76, 76),
                                          //               fontSize: 15,
                                          //               fontWeight:
                                          //                   FontWeight.w300),
                                          //         ))),
                                          Expanded(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  padding: EdgeInsets.all(20),
                                                  alignment: Alignment.topLeft,
                                                  //height: 20,
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                            text:
                                                                documentSnapshot[
                                                                    'content']),
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            'Description of Incident',
                                                        border:
                                                            InputBorder.none),
                                                    maxLines: 5,
                                                    readOnly: true,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ))),
                                        ],
                                      )),

                                      // child: Column(children: [
                                      //    Align(alignment: Alignment.topLeft,child:Column(children: [
                                      //     Text(documentSnapshot['location'],style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
                                      //     Text(documentSnapshot['vehicleNo'],style: TextStyle(color: Color.fromARGB(255, 83, 76, 76),fontSize: 15,fontWeight: FontWeight.w300),),
                                      //     Expanded(child: Text(documentSnapshot['content'],style: TextStyle(color: Colors.black),))

                                      //    ]),
                                      //    ),

                                      // ],)
                                    ),

                                    // Container(child: Align(alignment: Alignment.topLeft,child:Text(documentSnapshot['location'],style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),))),
                                    // Container(child: Align(alignment: Alignment.topLeft,child:Text(documentSnapshot['vehicleNo'],style: TextStyle(color: Color.fromARGB(255, 83, 76, 76),fontSize: 15,fontWeight: FontWeight.w300),))),
                                    // Container(child: Align(alignment: Alignment.topLeft,child:Text(documentSnapshot['content'],style: TextStyle(color: Colors.black),))),
                                  ]),
                                );
                              });
                        },
                        contentPadding: EdgeInsets.all(16),

                        //list tasks with their title and status
                        title: Text(
                          documentSnapshot['location'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          documentSnapshot['content'],
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),

                        tileColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),

                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Color.fromARGB(255, 179, 231, 121),
                          onPressed: () {
                            // setState(() {
                            //   //delete an item
                            //   deletReports(documentSnapshot.reference.id);
                            // });
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    title: const Text(
                                      'Delete confirmation',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Column(children: [
                                      Container(
                                        child: const Text(
                                          "Are you sure you want to delete this incident?",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w100,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                      SizedBox(
                                          height: 40,
                                          width: 80,
                                          child: Container(
                                            child: ElevatedButton(
                                              child: const Text('Yes'),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          Colors.black),
                                                  alignment: Alignment.center),
                                              onPressed: () {
                                                setState(() {
                                                  deletReports(documentSnapshot
                                                      .reference.id);
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ))
                                    ]),
                                  );
                                });
                          },
                        ),
                        //check box to update the status
                        leading: IconButton(
                          icon: Icon(
                            Icons.border_color,
                            color: Color.fromARGB(255, 179, 231, 121),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    content: Column(children: [
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        child: const Text(
                                          "Update Reporting",
                                          style: TextStyle(
                                              fontSize: 27,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(16),
                                        child: TextField(
                                          controller: TextEditingController(
                                              text: documentSnapshot[
                                                  'vehicleNo']),
                                          decoration: InputDecoration(
                                            labelText: 'Vehicle Number',
                                          ),
                                          readOnly: true,
                                          onChanged: ((value) {
                                            content = value;
                                          }),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(16),
                                        child: TextField(
                                          controller: TextEditingController(
                                              text:
                                                  documentSnapshot['location']),
                                          decoration: InputDecoration(
                                              labelText: 'Update Location',
                                              border: OutlineInputBorder(),
                                              prefixIcon: Icon(
                                                Icons.edit,
                                                color: Colors.black,
                                              )),
                                          maxLines: 5,
                                          onChanged: ((value) {
                                            content = value;
                                          }),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(16),
                                        child: TextField(
                                          controller: TextEditingController(
                                              text:
                                                  documentSnapshot['content']),
                                          decoration: InputDecoration(
                                              labelText: 'Update Description',
                                              border: OutlineInputBorder(),
                                              prefixIcon: Icon(
                                                Icons.edit,
                                                color: Colors.black,
                                              )),
                                          maxLines: 10,
                                          onChanged: ((value) {
                                            content = value;
                                          }),
                                        ),
                                      ),
                                      // Container(
                                      //   child: TextField(
                                      //     controller: TextEditingController(
                                      //         text: documentSnapshot[
                                      //             'vehicleNo']),
                                      //     autofocus: true,
                                      //     decoration: InputDecoration(
                                      //         hintText: 'Vehicle No',
                                      //         border: InputBorder.none),
                                      //     readOnly: true,
                                      //   ),
                                      // ),
                                      // Container(
                                      //   child: TextField(
                                      //     controller: TextEditingController(
                                      //         text:
                                      //             documentSnapshot['location']),
                                      //     autofocus: true,
                                      //     decoration: InputDecoration(
                                      //         hintText: 'Title',
                                      //         border: InputBorder.none),
                                      //     readOnly: true,
                                      //   ),
                                      // ),
                                      // Container(
                                      //   padding: EdgeInsets.all(16),
                                      //   child: TextField(
                                      //     controller: TextEditingController(
                                      //         text:
                                      //             documentSnapshot['content']),
                                      //     decoration: InputDecoration(
                                      //       labelText: 'Type',
                                      //       border: OutlineInputBorder(),
                                      //     ),
                                      //     maxLines: 15,
                                      //     onChanged: ((value) {
                                      //       content = value;
                                      //     }),
                                      //   ),
                                      // ),
                                    ]),
                                    actions: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: SizedBox(
                                          child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  updateReports(
                                                      documentSnapshot
                                                          .reference.id,
                                                      content);
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Color.fromARGB(
                                                            255, 72, 135, 70)),
                                                alignment: Alignment.center,
                                              ),
                                              child: const Text("update")),
                                        ),
                                      )
                                    ],
                                  );
                                });
                          },
                        ),
                      ));
                }));
          }),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            //  backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All Reports',
            // backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Reports',
            // backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Report',
            //  backgroundColor: Colors.grey,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

// ignore_for_file: file_names

import 'package:climatrix/screens/HomeScreen.dart';
import 'package:climatrix/screens/LoginPage.dart';
import 'package:climatrix/screens/all/AllIssues.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Issues extends StatefulWidget {
  final User? user;
  const Issues(this.user, {super.key});

  @override
  State<Issues> createState() => _IssuesState();
}

class _IssuesState extends State<Issues> {
  var txt = TextEditingController();
  String issueName = "";
  String issueType = "";
  String location = "";
  String content = "";

  static User? get user => null;

  //Function to add tasks to the list
  createIssues() {
    CollectionReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.user!.uid)
            .collection('Issues');
    Map<String, String> Issues = {
      'issueName': issueName,
      "issueType": issueType,
      'location': location,
      'content': content
    };
    documentReference.add(Issues).whenComplete(() => print("input created"));
  }

  //function to delete items from the issues list
  deletIssues(item) {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user!.uid)
        .collection('Issues')
        .doc(item);

    documentReference.delete().whenComplete(() => print("issue deleted"));
  }

  //function to update the status of a task by clicking on the check box
  updateIssues(itemId, content) {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user!.uid)
        .collection('Issues')
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
        MaterialPageRoute(builder: (context) => AllIssues(widget.user)));
  }

  mynavigation() {}
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
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: <Color>[Colors.lightGreen, Colors.cyan])),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    "New issue",
                    style: TextStyle(fontSize: 27, color: Colors.black),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Issue name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: ((value) {
                      issueName = value;
                    }),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Drought, Flood',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: ((value) {
                      issueType = value;
                    }),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: ((value) {
                      location = value;
                    }),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Solution',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 9,
                    onChanged: ((value) {
                      content = value;
                    }),
                  ),
                ),
              ],
            ),
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
                              createIssues();
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
        title: const Text('My Issues'),
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
              .collection('Issues')
              .snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: ((context, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];

                  //View SIngle Issue
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
                                              "View issue",
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
                                                      'issueName']),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              decoration: InputDecoration(
                                                labelText: 'Issue Name',
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
                                                  text: documentSnapshot[
                                                      'issueType']),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              decoration: InputDecoration(
                                                labelText: 'Issue Type',
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
                                                  text: documentSnapshot[
                                                      'location']),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              decoration: InputDecoration(
                                                labelText: 'Issue Location',
                                              ),
                                              readOnly: true,
                                              onChanged: ((value) {
                                                content = value;
                                              }),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(20),
                                            child: TextField(
                                              controller: TextEditingController(
                                                  text: documentSnapshot[
                                                      'content']),
                                              decoration: InputDecoration(
                                                  labelText: 'Solution',
                                                  border: InputBorder.none),
                                              maxLines: 5,
                                              readOnly: true,
                                              onChanged: ((value) {
                                                content = value;
                                              }),
                                            ),
                                          ),
                                        ],
                                      )),
                                    ),
                                  ]),
                                );
                              });
                        },
                        contentPadding: EdgeInsets.all(16),

                        //list tasks with their type and location
                        title: Text(
                          documentSnapshot['issueType'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          documentSnapshot['location'],
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
                            showDialog(
                                context: context,
                                builder: (context) {
                                  //delete issue
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
                                    content: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: const Text(
                                              "Are you sure you want to delete this issue?",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w100,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                          SizedBox(
                                              height: 50,
                                              width: 100,
                                              child: Container(
                                                child: ElevatedButton(
                                                  child: const Text('Yes'),
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              Colors.black),
                                                      alignment:
                                                          Alignment.center),
                                                  onPressed: () {
                                                    setState(() {
                                                      deletIssues(
                                                          documentSnapshot
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
                        //Update Issues
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
                                          "Update issue",
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
                                                  'issueName']),
                                          decoration: InputDecoration(
                                            labelText: 'Issue Name',
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
                                              text: documentSnapshot[
                                                  'issueType']),
                                          decoration: InputDecoration(
                                              labelText: 'Update Issue Type',
                                              border: OutlineInputBorder(),
                                              prefixIcon: Icon(
                                                Icons.edit,
                                                color: Colors.black,
                                              )),
                                          maxLines: 1,
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
                                                  documentSnapshot['content']),
                                          decoration: InputDecoration(
                                              labelText: 'Update Solution',
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
                                    ]),
                                    actions: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: SizedBox(
                                          child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  updateIssues(
                                                      documentSnapshot
                                                          .reference.id,
                                                      content);
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          Color.fromARGB(
                                                              255, 49, 112, 7)),
                                                  alignment: Alignment.center),
                                              child: const Text("Update")),
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
            label: 'All Issues',
            // backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Issues',
            // backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add issue',
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

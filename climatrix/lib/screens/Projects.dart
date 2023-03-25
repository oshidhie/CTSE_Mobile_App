// ignore_for_file: file_names

import 'package:climatrix/screens/HomeScreen.dart';
import 'package:climatrix/screens/LoginPage.dart';
import 'package:climatrix/screens/all/AllProjects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Projects extends StatefulWidget {
  final User? user;
  const Projects(this.user, {super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  var txt = TextEditingController();
  String chairName = "";
  String orgName = "";
  String projectTitle = "";
  String content = "";

  static User? get user => null;

  //Function to add tasks to the list
  createProjects() {
    CollectionReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.user!.uid)
            .collection('Projects');
    Map<String, String> Projects = {
      'chairName': chairName,
      'orgName': orgName,
      "projectTitle": projectTitle,
      'content': content
    };
    documentReference.add(Projects).whenComplete(() => print("input created"));
  }

  //function to delete items from the list
  deletProjects(item) {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user!.uid)
        .collection('Projects')
        .doc(item);

    documentReference.delete().whenComplete(() => print("project deleted"));
  }

  //function to update the status of a task by clicking on the check box
  updateProjects(itemId, content) {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user!.uid)
        .collection('Projects')
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
        MaterialPageRoute(builder: (context) => AllProjects(widget.user)));
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
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "New project",
                    style: TextStyle(fontSize: 27, color: Colors.black),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Chairperson',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        )),
                    onChanged: ((value) {
                      chairName = value;
                    }),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Organization',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        )),
                    onChanged: ((value) {
                      orgName = value;
                    }),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Enter your project title',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.title,
                          color: Colors.black,
                        )),
                    onChanged: ((value) {
                      projectTitle = value;
                    }),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.edit_document,
                          color: Colors.black,
                        )),
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
                              createProjects();
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
        title: const Text('My Projects'),
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
              .collection('Projects')
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
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                      text: documentSnapshot[
                                                          'projectTitle'],
                                                    ),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                    readOnly: true,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ))),
                                          Container(
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                      text: documentSnapshot[
                                                          'chairName'],
                                                    ),
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        labelText:
                                                            'Chairperson'),
                                                    readOnly: true,
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 83, 76, 76),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ))),
                                          Container(
                                              child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                      text: documentSnapshot[
                                                          'orgName'],
                                                    ),
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        labelText:
                                                            'Organization'),
                                                    readOnly: true,
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 83, 76, 76),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ))),
                                          Expanded(
                                              child: TextField(
                                            controller: TextEditingController(
                                                text: documentSnapshot[
                                                    'content']),
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                labelText:
                                                    'Project Description'),
                                            maxLines: 15,
                                            readOnly: true,
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                        ],
                                      )),
                                    ),
                                  ]),
                                );
                              });
                        },
                        contentPadding: EdgeInsets.all(16),

                        //list tasks with their title and status
                        title: Text(
                          documentSnapshot['projectTitle'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        subtitle: Text(
                          documentSnapshot['chairName'],
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.grey),
                        ),

                        tileColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),

                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Color.fromARGB(255, 248, 79, 79),
                          onPressed: () {
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
                                          "Are you sure you want to delete this post?",
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
                                              child: const Text('sure'),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          Colors.black),
                                                  alignment:
                                                      Alignment.bottomCenter),
                                              onPressed: () {
                                                setState(() {
                                                  deletProjects(documentSnapshot
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
                                        padding: EdgeInsets.all(16),
                                        child: TextField(
                                          controller: TextEditingController(
                                              text: documentSnapshot[
                                                  'chairName']),
                                          autofocus: true,
                                          decoration: InputDecoration(
                                            hintText: 'ChairPerson Name',
                                            labelText: 'Chairperson',
                                            border: OutlineInputBorder(),
                                          ),
                                           onChanged: ((value) {
                                            chairName = value;
                                          }),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(16),
                                        child: TextField(
                                          controller: TextEditingController(
                                              text:
                                                  documentSnapshot['orgName']),
                                          autofocus: true,
                                          decoration: InputDecoration(
                                            hintText: 'Organization',
                                            labelText: 'Organization',
                                            border: OutlineInputBorder(),
                                          ),
                                          onChanged: ((value) {
                                            orgName = value;
                                          }),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(16),
                                        child: TextField(
                                          controller: TextEditingController(
                                              text: documentSnapshot[
                                                  'projectTitle']),
                                          autofocus: true,
                                          decoration: InputDecoration(
                                            hintText: 'Title',
                                            labelText: 'Project Title',
                                            border: OutlineInputBorder(),
                                          ),
                                          onChanged: ((value) {
                                            projectTitle = value;
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
                                              labelText: 'Description',
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
                                    ]),
                                    actions: [
                                      SizedBox(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              updateProjects(
                                                  documentSnapshot.reference.id,
                                                  content);
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("update"),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.black),
                                              alignment: Alignment.center),
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
            label: 'All Projects',
            // backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Projects',
            // backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add project',
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

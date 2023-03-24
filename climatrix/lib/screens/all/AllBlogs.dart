// ignore_for_file: file_names

import 'package:climatrix/screens/HomeScreen.dart';
import 'package:climatrix/screens/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Blogs.dart';

class AllBlogs extends StatefulWidget {
  final User? user;
  const AllBlogs(this.user, {super.key});

  @override
  State<AllBlogs> createState() => _AllBlogsState();
}

class _AllBlogsState extends State<AllBlogs> {
  var txt = TextEditingController();

  static User? get user => null;

  int _selectedIndex = 1;

  homenavigation() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => HomePage(widget.user)));
  }

  allnavigation() {
    //  Navigator.push(context,
    //  MaterialPageRoute(builder: (context) => HomePage(widget.user)));
  }
  mynavigation() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Blogs(widget.user)));
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
        title: const Text('All Blogs'),
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
          stream:
              FirebaseFirestore.instance.collectionGroup('Blogs').snapshots(),
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
                                                  alignment: Alignment.topLeft,
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                      text: documentSnapshot[
                                                          'blogTitle'],
                                                    ),
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        labelText: 'Title'),
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
                                                          'authorName'],
                                                    ),
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        labelText: 'Author'),
                                                    readOnly: true,
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 83, 76, 76),
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ))),
                                          Expanded(
                                              child:
                                                  // decoration: BoxDecoration(
                                                  //   gradient: LinearGradient(
                                                  //       colors: [
                                                  //         Colors.lightGreen,
                                                  //         Colors.cyan
                                                  //       ]),
                                                  //   borderRadius:
                                                  //       BorderRadius.circular(
                                                  //           8),
                                                  // ),

                                                  TextField(
                                            controller: TextEditingController(
                                                text: documentSnapshot[
                                                    'content']),
                                            decoration: InputDecoration(
                                                border: InputBorder.none),
                                            maxLines: 15,
                                            readOnly: true,
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                        ],
                                      )),

                                      // child: Column(children: [
                                      //    Align(alignment: Alignment.topLeft,child:Column(children: [
                                      //     Text(documentSnapshot['blogTitle'],style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
                                      //     Text(documentSnapshot['authorName'],style: TextStyle(color: Color.fromARGB(255, 83, 76, 76),fontSize: 15,fontWeight: FontWeight.w300),),
                                      //     Expanded(child: Text(documentSnapshot['content'],style: TextStyle(color: Colors.black),))

                                      //    ]),
                                      //    ),

                                      // ],)
                                    ),

                                    // Container(child: Align(alignment: Alignment.topLeft,child:Text(documentSnapshot['blogTitle'],style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),))),
                                    // Container(child: Align(alignment: Alignment.topLeft,child:Text(documentSnapshot['authorName'],style: TextStyle(color: Color.fromARGB(255, 83, 76, 76),fontSize: 15,fontWeight: FontWeight.w300),))),
                                    // Container(child: Align(alignment: Alignment.topLeft,child:Text(documentSnapshot['content'],style: TextStyle(color: Colors.black),))),
                                  ]),
                                );
                              });
                        },
                        contentPadding: EdgeInsets.all(16),
                         title: Text(
                          documentSnapshot['blogTitle'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        subtitle: Text(
                          documentSnapshot['authorName'],
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.grey),
                        ),
                        tileColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
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
            label: 'All Blogs',
            // backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Blogs',
            // backgroundColor: Colors.grey,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

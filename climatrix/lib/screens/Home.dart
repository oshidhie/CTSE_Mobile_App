
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practiceblogapp/services/crud.dart';
import 'package:practiceblogapp/screens/createBlog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practiceblogapp/screens/LoginPage.dart';

class Home extends StatefulWidget {
 final User? user;
const Home(this.user, {super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var txt = TextEditingController();
  String authorName = "";
  String blogTitle = "";
  String content = "";

  //Function to add tasks to the list
  createTodos() {
    CollectionReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection('users').doc(widget.user!.uid).collection('blogs');
    Map<String, String> todos = {'authorName':authorName,"blogTitle": blogTitle, 'content':content};
    documentReference.add(todos).whenComplete(() => print("input created"));
  }
  //function to delete items from the todo list
  deletTodos(item) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('users').doc(widget.user!.uid).collection('blogs').doc(item);

    documentReference.delete().whenComplete(() => print("blog deleted"));
  }
 //function to update the status of a task by clicking on the check box
  updateTodos(itemId,content) {
    
    DocumentReference documentReference =
         FirebaseFirestore.instance.collection('users').doc(widget.user!.uid).collection('blogs').doc(itemId);
    documentReference
        .update({'content':content}).whenComplete(() => print("Updated"));
  }
  // @override
  // void initState() {

  //   super.initState();
  //   todos.add('Item1');
  //   todos.add('Item2');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.alphaBlend(Colors.lightBlue, Colors.black),
          title: const Text('My ToDos'),
          
        ),
        backgroundColor: Colors.white,
        
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              //pop dialog box to add tasks
              showDialog(
                  context: context,
                  builder: ((context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),shadowColor: Colors.purple,

                      content: Column(
                        children: <Widget>[
                          Container(padding: EdgeInsets.all(16),
                            child: TextField(
                              decoration:
                                  InputDecoration(labelText: 'Author name',border: OutlineInputBorder()),
                                  
                              onChanged: ((value) {
                                authorName= value;
                              }),
                            ),
                          ),
                           Container(padding: EdgeInsets.all(16),
                            child: TextField(
                              decoration:
                                  InputDecoration(labelText: 'Enter your blog title',border: OutlineInputBorder()),
                              onChanged: ((value) {
                                blogTitle= value;
                              }),
                            ),
                          ),Container(padding: EdgeInsets.all(16),
                            child: TextField(
                              decoration:
                                  InputDecoration(labelText: 'Type',border: OutlineInputBorder()),
                                  maxLines: 15,
                              onChanged: ((value) {
                                content= value;
                              }),
                            ),
                          ),
                          // Container(
                          //   child: TextField(onChanged: (value) {
                          //     cstatus=value;
                          //   },
                          //     decoration: InputDecoration(labelText: 'Add ToDo'),),
                          // )
                        ],
                      ),
                      // content: TextField(onChanged: (value) {
                      //   input=value;
                      // },),
                      // submit button
                      actions: [Align(
                        alignment: Alignment.topCenter,
                        child:ElevatedButton(
                          
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.black)),
                            onPressed: () {
                              setState(() {
                                //add tasks
                                createTodos();
                              });
                              //pop out dialog box after adding a task
                              Navigator.of(context).pop();
                            },
                            child: const Text("Add"))
                      )
                        
                      ],
                    );
                  }));
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            )),
            //stream builder to list the tasks
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').doc(widget.user!.uid).collection('blogs').snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: ((context, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  return Card(
                    key: Key(index.toString()),
                    child: ListTile(onTap: () {
                          showDialog(context: context, builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
            
            ),
            content: Column(children: [
              SingleChildScrollView(
                child: IntrinsicHeight(child: Column(children: [
                  Container(child: Align(alignment: Alignment.topLeft,child:Text(documentSnapshot['blogTitle'],style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),))),
                  Container(child: Align(alignment: Alignment.topLeft,child:Text(documentSnapshot['authorName'],style: TextStyle(color: Color.fromARGB(255, 83, 76, 76),fontSize: 15,fontWeight: FontWeight.w300),))),
                  Expanded(child:Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.lightBlue,Colors.white]),borderRadius: BorderRadius.circular(8),),padding: EdgeInsets.all(20),alignment: Alignment.topLeft,height:600,child:TextField(controller:TextEditingController(text: documentSnapshot['content']),decoration: InputDecoration(border: InputBorder.none),maxLines: 50 ,readOnly: true,style: TextStyle(color: Colors.black),))), 
                ],)),

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
                      //list tasks with their title and statusr
                      title: Text(documentSnapshot['blogTitle']),
                      subtitle: Text(documentSnapshot['authorName']),
                      tileColor:Colors.blueGrey ,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.black,
                        onPressed: () {
                          // setState(() {
                          //   //delete an item
                          //   deletTodos(documentSnapshot.reference.id);
                          // });
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              title: const Text('Delete confirmation'),
                              
                              content: Column(children: [
                                Container(child: const  Text("Are you sure you want to delete this post?"),),
                                Container(child: ElevatedButton(child: const Text('sure'),onPressed: () {
                                  setState(() {
                                    deletTodos(documentSnapshot.reference.id);
                                  });Navigator.of(context).pop();
                                },),)
                              ]),
                            );
                          });
                          
                        },
                      ),
                      //check box to update the status
                  leading: IconButton(icon: Icon(Icons.border_color),onPressed: (){
              showDialog(context: context, builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
            
            ),
            content: Column(children: [
            
              Container(child: TextField(controller: TextEditingController(text:documentSnapshot['authorName']),autofocus: true,decoration: InputDecoration(hintText: 'Author name',border: InputBorder.none),readOnly: true,),),
              Container(child: TextField(controller: TextEditingController(text:documentSnapshot['blogTitle']),autofocus: true,decoration: InputDecoration(hintText: 'Title',border: InputBorder.none),readOnly: true,),),
            Container(padding: EdgeInsets.all(16),
                            child: TextField(controller: TextEditingController(text: documentSnapshot['content']),
                              decoration:
                                  InputDecoration(labelText: 'Type',border: OutlineInputBorder()),
                                  maxLines: 15,
                              onChanged: ((value) {
                                content= value;
                              }),
                            ),
                          ),
            ]),
            actions: [ElevatedButton(onPressed: (){
              setState(() {
                updateTodos(documentSnapshot.reference.id, content);
              });
              Navigator.of(context).pop();
            }, child: const Text("update"),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),)],
          );
          
        });
          },),));

              
                  
                }));
          
      
          }),);}
}

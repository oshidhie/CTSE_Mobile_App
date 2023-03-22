
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practiceblogapp/services/crud.dart';
import 'package:practiceblogapp/screens/createBlog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practiceblogapp/screens/LoginPage.dart';

class others extends StatefulWidget {


  @override
  State<others> createState() => _othersState();
}

class _othersState extends State<others> {
  // var txt = TextEditingController();
  // String authorName = "";
  // String blogTitle = "";
  // String content = "";

//   //Function to add tasks to the list
//   createTodos() {
//     CollectionReference<Map<String, dynamic>> documentReference =
//         FirebaseFirestore.instance.collection('users').doc().collection('blogs');
//     Map<String, String> todos = {'authorName':authorName,"blogTitle": blogTitle, 'content':content};
//     documentReference.add(todos).whenComplete(() => print("input created"));
//   }
//   //function to delete items from the todo list
//   deletTodos(item) {
//     DocumentReference documentReference =
//         FirebaseFirestore.instance.collection('users').doc(widget.user!.uid).collection('blogs').doc(item);

//     documentReference.delete().whenComplete(() => print("blog deleted"));
//   }
//  //function to update the status of a task by clicking on the check box
//   updateTodos(itemId,content) {
    
//     DocumentReference documentReference =
//          FirebaseFirestore.instance.collection('users').doc(widget.user!.uid).collection('blogs').doc(itemId);
//     documentReference
//         .update({'content':content}).whenComplete(() => print("Updated"));
//   }
//   // @override
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
        
            //stream builder to list the tasks
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').doc().collection('blogs').snapshots(),
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
                      
                      
                      //check box to update the status
            ));

              
                  
                }));
          
      
          }),);}
}

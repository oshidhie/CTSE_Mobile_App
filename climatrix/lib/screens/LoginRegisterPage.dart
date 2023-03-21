// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:practiceblogapp/screens/Home.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   String _errorMessage = "";

//   Future <void> _login()async{
//    try{
//      UserCredential credential = await auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
//      if(mounted){
//       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
//         return Home() ;
//       }));
//      }
//    }on FirebaseAuthException catch(e){
//     setState(() {
//       _errorMessage = e.message!;
//     });
//    }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Recipe App'),
//       backgroundColor: Colors.orange,),
//       body: Center(child: Padding(padding: EdgeInsets.all(8.0),child: Column(children: [
//         TextField(
//           controller: _emailController,
//           decoration: InputDecoration(hintText: 'Enter your Email'),
//         ),
//          TextField(
//           controller: _passwordController,
//           decoration: InputDecoration(hintText: 'Enter your password'),
//           obscureText: true,
//         ),const SizedBox(height: 10.0,),
//         ElevatedButton(onPressed: (){
//           _login();
//         }, child: const Text("Login"),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.orange)),),
//         Text(_errorMessage,style: const TextStyle(color: Colors.red),)
        
//       ],),),
//       )
//     );
//   }
// }
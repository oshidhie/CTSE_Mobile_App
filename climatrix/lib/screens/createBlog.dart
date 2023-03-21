import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:practiceblogapp/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  late String authorName, title, desc;

  late File selectedImage;
  bool _isLoading = false;
  CrudMethods crudMethods = new CrudMethods();

  // Future getImage() async {
  //   var image = await ImagePicker().pickImage(source: ImageSource.gallery);


  //   setState(() {
  //     selectedImage = image;
  //   });
  // }

  uploadBlog() async {
    // if (selectedImage != null) {
    //   setState(() {
    //     _isLoading = true;
    //   });

      /// uploading image to firebase storage
    //  FirebaseStorage firebaseStorageRef = FirebaseStorage.instance
    //       .ref()
    //       .child("blogImages")
    //       .child("${randomAlphaNumeric(9)}.jpg");

    //   final StorageUploadTask task = firebaseStorageRef.putFile(selectedImage);

    //   var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
    //   print("this is url $downloadUrl");

      Map<String, String> blogMap = {
        
        "authorName": authorName,
        "title": title,
        "desc": desc
      };
      crudMethods.addData(blogMap).then((result) {
        Navigator.pop(context);
      });
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              uploadBlog();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.file_upload)),
          )
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                 
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(hintText: "Author Name"),
                          onChanged: (val) {
                            authorName = val;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: "Title"),
                          onChanged: (val) {
                            title = val;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: "Desc"),
                          onChanged: (val) {
                            desc = val;
                          },
                        ),
                        ElevatedButton(onPressed: (){
                          setState(() {
                            uploadBlog();
                          });
                        }, child: const Text('add'))
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
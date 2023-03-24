import 'package:climatrix/screens/Blogs.dart';
import 'package:climatrix/screens/Issues.dart';
import 'package:climatrix/screens/Projects.dart';
import 'package:climatrix/screens/Report.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'LoginPage.dart';

class HomePage extends StatefulWidget {
  final User? user;
  const HomePage(this.user, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    blognavigation() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Blogs(widget.user)));
    }

    projectnavigation() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Projects(widget.user)));
    }

    issuesnavigation() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Issues(widget.user)));
    }

    reportnavigation() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Reports(widget.user)));
    }

    return Scaffold(
      appBar: PreferredSize(
        //wrap with PreferredSize
        preferredSize: Size.fromHeight(50), //height of appbar
        child: AppBar(
          backgroundColor: Colors.black,
          leading: Icon(
            Icons.home,
          ),
          centerTitle: true,
          title: const Text('Home'),
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }),
          ],
        ),
      ),
      // ignore: avoid_unnecessary_containers
      body: Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Colors.lightGreen, Colors.cyan])),
          child: Padding(
            // padding: const EdgeInsets.all(20.0),
            // child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
              children: [
                InkWell(
                  onTap: () {
                    issuesnavigation();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 87, 197, 209),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          '../assests/isues.png',
                          height: 120,
                          width: 120,
                        ),
                        const Text(
                          "Issues",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    projectnavigation();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 87, 209, 207),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          '../assests/organization.png',
                          height: 120,
                          width: 120,
                        ),
                        const Text(
                          "Projects",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    blognavigation();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 87, 197, 209),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          '../assests/blogging.png',
                          height: 120,
                          width: 120,
                        ),
                        const Text(
                          "Blogs",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    reportnavigation();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 87, 209, 207),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          '../assests/report.png',
                          height: 120,
                          width: 120,
                        ),
                        const Text(
                          "Report",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    //);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[Colors.lightGreen, Colors.cyan])),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            children: [
              InkWell(
                // onTap: () {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => HomePage()));
                // },
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
                        height: 80,
                        width: 80,
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
                // onTap: () {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => HomePage()));
                // },
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
                        height: 80,
                        width: 80,
                      ),
                      const Text(
                        "Organization",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                // onTap: () {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => HomePage()));
                // },
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
                        height: 80,
                        width: 80,
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
                // onTap: () {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => HomePage()));
                // },
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
                        height: 80,
                        width: 80,
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
    );
  }
}

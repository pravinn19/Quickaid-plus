import 'package:flutter/material.dart';
import 'package:quickaid/forum_screen.dart';
import 'package:quickaid/request_form.dart';

import 'constants.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  handsimage,
                  height: height * 0.30,
                  width: width,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: height * 0.35,
                  width: width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        stops: [0.5, 0.9],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black]),
                  ),
                ),
              ],
            ),
            SizedBox(
              child: Text(
                "Welcome",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              height: 40,
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Container(
                    height: height * 0.5,
                    width: width * 0.85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[850],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 140),
                  child: Column(
                    children: [
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Requestform()),
                            );
                          },
                          child: Text(
                            "Request Form",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.deepOrangeAccent),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            fixedSize: MaterialStateProperty.all(
                              Size(150, 60),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => (Homescreen())),
                            );
                          },
                          child: Text(
                            "Feed",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.deepOrangeAccent),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              fixedSize: MaterialStateProperty.all(
                                Size(150, 60),
                              ),
                              elevation: MaterialStateProperty.all(15)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickaid/request_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickaid/welcome.dart';

import 'constants.dart';

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _currentuser = FirebaseAuth.instance.currentUser!.email;
    final _currentname = FirebaseAuth.instance.currentUser!.displayName;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Feed"),
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.deepOrangeAccent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              accountName: Text("pravin"),
              accountEmail: Text(_currentuser!),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Welcome()));
              },
              title: Text('Home'),
              leading: Icon(Icons.home),
            ),
            Divider(
              height: 0.1,
            ),
            ListTile(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Requestform())),
              title: Text('Request an item'),
              leading: Icon(Icons.delivery_dining),
            ),
            Divider(
              height: 0.1,
            ),
            // ListTile(
            //   title: Text('Maps'),
            //   leading: Icon(Icons.map),
            // ),
            Divider(
              height: 0.1,
            )
          ],
        ),
      ),
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
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Datum")
                  .orderBy('Server')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    // Map<String, dynamic> data =
                    //     document.data()! as Map<String, dynamic>;
                    Text("Request section");
                    return Center(
                      child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                height: height * 0.5,
                                width: width * 0.85,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.deepOrangeAccent,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 70,
                              left: 30,
                              child: Column(
                                children: [
                                  Text(
                                    "Name :   " + document['Name'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Number :   " + document['PNumber'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Category :   " + document['Category'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Requested item :   " + document['Item'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Lending duration : " +
                                        document['Duration'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

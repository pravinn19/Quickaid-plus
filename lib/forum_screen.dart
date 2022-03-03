import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickaid/request_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickaid/welcome.dart';

import 'constants.dart';

class Homescreen extends StatefulWidget {
  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Object? _value;

  List _list = [];
  List _filteredList = [];

  @override
  void initState() {
    super.initState();
    List templist = [];
    FirebaseFirestore.instance
        .collection("Datum")
        .orderBy('Server')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        templist.add(element.data());
      });

      setState(() {
        _list = templist;
        _filteredList = templist;
      });
    });
  }

  void filterList(value) {
    List tempList = [];
    _list.forEach((element) {
      if (element['Area'] == value) {
        tempList.add(element);
      }
    });
    setState(() {
      _filteredList = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _currentuser = FirebaseAuth.instance.currentUser!.email;
    final _currentname = FirebaseAuth.instance.currentUser!.displayName;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(_list[0]['Name']);
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
            Container(
              child: DropdownButton(
                onChanged: (value) => filterList(value),
                items: [
                  DropdownMenuItem(
                    child: Text("Chennai"),
                    value: "Chennai",
                  ),
                  DropdownMenuItem(
                    child: Text("Puducherry"),
                    value: "Puducherry",
                  ),
                  DropdownMenuItem(
                    child: Text("Kancheepuram"),
                    value: "Kancheepuram",
                  ),
                  DropdownMenuItem(
                    child: Text("Vellore"),
                    value: "Vellore",
                  ),
                  DropdownMenuItem(
                    child: Text("Thiruvallur"),
                    value: "Thiruvallur",
                  ),
                ],
                dropdownColor: Colors.white,
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _filteredList.length,
                itemBuilder: (context, index) {
                  return Center(
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
                              "Name :   " + _filteredList[index]['Name'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Number :   " + _filteredList[index]['PNumber'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Category :   " +
                                  _filteredList[index]['Category'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Requested item :   " +
                                  _filteredList[index]['Item'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Lending duration : " +
                                  _filteredList[index]['Duration'],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )

// Text(
                      //   _list[index]['Name'],
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold, color: Colors.blue),
                      // ),
                      ); //
                })
            // ListView(
            //         shrinkWrap: true,
            //         physics: NeverScrollableScrollPhysics(),
            //         children:
            //             _list.map((DocumentSnapshot document) {
            //           // Map<String, dynamic> data =
            //           //     document.data()! as Map<String, dynamic>;
            //           Text("Request section");
            //           return Center(
            //             child: SingleChildScrollView(
            //               child:

            //             ),
            //           );
            //         }).toList(),
            //       )
          ],
        ),
      ),
    );
  }
}

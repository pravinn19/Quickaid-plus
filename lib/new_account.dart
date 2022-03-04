import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickaid/login_screen.dart';

import 'constants.dart';

class Newaccount extends StatefulWidget {
  @override
  _NewaccountState createState() => _NewaccountState();
}

class _NewaccountState extends State<Newaccount> {
  // final _uname = TextEditingController();
  String? _uname;
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;

  String? email, password;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Create your account"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    bgimage,
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
              Text(
                "Registration Page",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 30.0,
                    color: Colors.deepOrangeAccent),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  // controller: _uname,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    _uname = value; //get the value entered by user.
                  },
                  decoration: InputDecoration(
                      labelText: "Enter your name",
                      labelStyle: TextStyle(
                          color: Colors.deepOrangeAccent, fontSize: 17),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepOrangeAccent)),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(32.0)))),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value; //get the value entered by user.
                  },
                  decoration: InputDecoration(
                      labelText: "Enter the Email",
                      labelStyle: TextStyle(
                          color: Colors.deepOrangeAccent, fontSize: 17),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepOrangeAccent)),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(32.0)))),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value; //get the value entered by user.
                  },
                  decoration: InputDecoration(
                      labelText: "Enter the Password",
                      labelStyle: TextStyle(
                          color: Colors.deepOrangeAccent, fontSize: 17),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepOrangeAccent)),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(32.0)))),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Material(
                elevation: 5,
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(32.0),
                child: MaterialButton(
                  color: Colors.deepOrangeAccent,
                  onPressed: () async {
                    setState(() {
                      showProgress = true;
                    });
                    try {
                      final newuser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email!, password: password!);

                      if (newuser != null) {
                        setState(() {
                          showProgress = false;
                        });
                      }
                    } catch (e) {}
                    FirebaseAuth.instance.currentUser!
                        .updateDisplayName(_uname);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  minWidth: 200.0,
                  height: 50.0,
                  child: Text(
                    "Register",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              GestureDetector(
                onTap: () {},
                child: GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen())),
                  child: Text(
                    "Already Registred? Login Now",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:quickaid/forum_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickaid/new_account.dart';
import 'package:quickaid/welcome.dart';
import 'constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _controlleremail = TextEditingController();

  String? _email, _password;

  void signIn(BuildContext context) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email!, password: _password!)
        .catchError((onError) {})
        .then((authUser) {
      if (authUser.user != null)
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Welcome()));
    });

    final _taskemail = _controlleremail.text;

    FirebaseFirestore.instance.collection("Datum").add({"Email": _taskemail});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black54,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                            stops: [0.4, 0.9],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black]),
                      ),
                      //color: Colors.indigo.withOpacity(0.2),
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    appName,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.deepOrangeAccent),
                  ),
                ),
                Center(
                  child: Text(
                    slogan,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Container(
                    child: Text("  $loginin",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepOrangeAccent.withOpacity(0.8),
                            Colors.transparent
                          ],
                        ),
                        border: Border(
                            left: BorderSide(
                                color: Colors.deepOrangeAccent, width: 5))),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
                  child: TextFormField(
                    controller: _controlleremail,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    onSaved: (value) {
                      _email = value!;
                    },
                    validator: (String? email) {
                      if (email!.isEmpty)
                        return "Please Enter Email";
                      else if (!RegExp(
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
                              caseSensitive: false)
                          .hasMatch(email)) return "Not a Valid ID";
                      return null;
                    },
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepOrangeAccent)),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.deepOrangeAccent,
                        ),
                        labelText: " EMAIL ADDRESS",
                        labelStyle: TextStyle(
                            color: Colors.deepOrangeAccent, fontSize: 17)),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 3.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    onSaved: (value) {
                      _password = value!;
                    },
                    validator: (password) {
                      if (password!.isEmpty)
                        return "Please Enter Password";
                      else if (password.length < 8 || password.length > 15)
                        return "Password criteria not met";
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepOrangeAccent)),
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.deepOrangeAccent,
                        ),
                        labelText: " PASSWORD",
                        labelStyle: TextStyle(
                            color: Colors.deepOrangeAccent, fontSize: 17)),
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(forgettext),
                        style: TextButton.styleFrom(
                            primary: Colors.deepOrangeAccent))),
                Center(
                  child: SizedBox(
                    height: height * 0.08,
                    width: width * 0.85,
                    child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            signIn(context);
                            // if (_email == "pravin@g.com" &&
                            //     _password == "root12345") {
                            //   onTap:
                            //   () => FocusScope.of(context).unfocus();
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => Homescreen(),
                            //     ),
                            //   );
                            // } else {
                            //   print("invalid login");
                            // }
                          }
                        },
                        child: Text("Login to Account"),
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(200, 50),
                            primary: Colors.deepOrangeAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)))),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Newaccount()));
                      },
                      child: Text("Create Account"),
                      style: TextButton.styleFrom(
                          primary: Colors.deepOrangeAccent),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

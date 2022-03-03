import 'package:flutter/material.dart';
import 'constants.dart';

class detailspage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
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
                          stops: [0.4, 0.9],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black]),
                    ),
                    //color: Colors.indigo.withOpacity(0.2),
                  ),
                ],
              ),
              Container(
                height: height * 0.6,
                width: width * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.deepPurpleAccent,
                ),
              )
            ]));
  }
}

import 'package:flutter/material.dart';
import 'package:quickaid/details.dart';
import 'package:quickaid/forum_screen.dart';
import 'package:quickaid/welcome.dart';
import 'package:quickaid/request_form.dart';
import 'package:quickaid/new_account.dart';
import 'constants.dart';
import 'login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(InitialScreen());
}

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Welcome(),
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xffdd2c00),
          ),
          accentColor: Colors.deepOrangeAccent,
          fontFamily: GoogleFonts.montserrat().fontFamily,
          textTheme: GoogleFonts.montserratTextTheme()),
    );
  }
}

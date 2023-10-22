import 'dart:async';

import 'package:flutter/material.dart';
import 'package:serenity/pages/home_page.dart';
import 'package:serenity/realm/realm.dart';

void main() {
  // deleteRealmDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 77, 145, 245),
        fontFamily: 'Arizona',
        useMaterial3: true,
      ),
      home: FadeOutImageScreen(),
    );
  }
}

class FadeOutImageScreen extends StatefulWidget {
  @override
  FadeOutImageScreenState createState() => FadeOutImageScreenState();
}

class FadeOutImageScreenState extends State<FadeOutImageScreen> {
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 0), _startFading); //Fade in function if you want
  }

  void _startFading() {
    setState(() {
      _opacity = 0.0;
    });
Future.delayed(Duration(milliseconds: 2000), () {
      // Navigate to the new screen when opacity reaches 0
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    });
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(milliseconds: 2000), //Fade out = 2 s
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
  }

import 'package:flutter/material.dart';
import 'package:serenity/pages/home_page.dart';
import 'package:serenity/realm/realm.dart';

void main() {
  deleteRealmDatabase();
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        fontFamily: 'Arizona',
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

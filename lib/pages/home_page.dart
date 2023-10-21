import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});



  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Container(
          alignment:Alignment.center,
          child:const Text('Serenity')
          )


          ],
        ),
      ),
    );
  }
}


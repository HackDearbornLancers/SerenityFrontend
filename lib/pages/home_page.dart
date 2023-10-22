import 'package:flutter/material.dart';
import 'package:serenity/pages/journal_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Image.asset("assets/logo.png"),
            Spacer(flex: 2),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            Spacer(flex: 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text("Login", style: TextStyle(color: Colors.black)),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(150, 60)),

                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context)
                          .primaryColor
                          .withOpacity(1)), // Set the background color
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => JournalPage()));
                },
              ),
            ),
            Spacer(flex: 3)
          ],
        ),
      )),
    );
  }
}

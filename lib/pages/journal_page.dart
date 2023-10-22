import 'package:flutter/material.dart';
import 'package:serenity/realm/entry.dart';
import 'package:serenity/realm/realm.dart';
import 'package:serenity/widgets/create_entry.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => JournalPageState();
}

class JournalPageState extends State<JournalPage> {
  @override
  Widget build(BuildContext context) {
    var entries = realm.all<Entry>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // This handles the back action.
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CreateEntry();
                    });
              },
              icon: Icon(Icons.add))
        ],
        title: Text("Entries"),
      ),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(entries[index].name),
            onTap: () {
              // Action to perform when the ListTile is tapped.
            },
          );
        },
      ),
    );
  }
}

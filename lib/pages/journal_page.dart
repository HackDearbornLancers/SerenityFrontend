import 'package:flutter/material.dart';
import 'package:serenity/pages/entry_page.dart';
import 'package:serenity/pages/home_page.dart';
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
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage())); // This handles the back action.
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
      body: ListView.separated(
        itemCount: entries.length,
separatorBuilder: (context, index) {
          // Add space between tiles
          return SizedBox(height: 16); // Adjust the height for the desired space
        },
        itemBuilder: (BuildContext context, int index) {

          return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),

          border: Border.all(

              color: Colors.black, // Border color
              width: 1.0, // Border width
              
            ),
          ),
          child:
          
          ListTile(
            title: Text(entries[index].name),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EntryPage(
                      name: entries[index].name,
                      location: entries[index].location,
                      messages: entries[index].content)));
            },
          ));
        },
      ),
    );
  }
}

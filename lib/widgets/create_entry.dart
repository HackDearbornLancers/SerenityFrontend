import 'package:flutter/material.dart';
import 'package:serenity/pages/entry_page.dart';

class CreateEntry extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CreateEntryState();
  }
}

class CreateEntryState extends State<CreateEntry> {
  final TextEditingController _controller = TextEditingController();
  bool conversational = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
    scrollable:true,
      title: Text('Create Entry'),
      content: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Location',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Conversational"),
              Switch(
                // This bool value toggles the switch.
                value: conversational,
                activeColor: Colors.red,
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    conversational = value;
                  });
                },
              ),
            ],
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EntryPage(
                      name: _controller.text, location: _controller.text)));
            },
            child: Text('Create')),
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog.
          },
        ),
      ],
    );
  }
}

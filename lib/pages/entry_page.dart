import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:realm/realm.dart';
import 'package:serenity/realm/entry.dart';
import 'package:serenity/realm/realm.dart';

class EntryPage extends StatefulWidget {
  String name;
  final String location;
  EntryPage({Key? key, String? name, required this.location})
      : name = name ?? DateTime.now().toString(),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new EntryPageState();
  }
}

class Message {
  String content;
  String speaker;
  Message({required this.speaker, required this.content});
}

class EntryPageState extends State<EntryPage> {
  final QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  List<Message> messages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                if (!(_controller.document.isEmpty() && messages.isEmpty)) {
                  final entry = Entry(widget.name, DateTime.now(),
                      _controller.document.toPlainText(), widget.location, 0.5);
                  realm.write(() {
                    realm.add(entry);
                  });
                }

                Navigator.of(context).pop(); // This handles the back action.
              },
              icon: Icon(Icons.arrow_back)),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.speaker_notes)),
            TextButton(
                onPressed: () {
                  _focusNode.unfocus();
                },
                child: Text("Done"))
          ],
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
            child: QuillProvider(
              configurations: QuillConfigurations(controller: _controller),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: QuillEditor.basic(
                        focusNode: _focusNode,
                        readOnly: false, // true for view only mode
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}

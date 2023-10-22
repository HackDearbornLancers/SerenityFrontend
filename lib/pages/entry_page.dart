import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:realm/realm.dart';
import 'package:serenity/pages/journal_page.dart';
import 'package:serenity/realm/entry.dart';
import 'package:serenity/realm/realm.dart';
import 'package:serenity/reqs.dart';

class EntryPage extends StatefulWidget {
  String name;
  final String location;
  EntryPage({Key? key, String? name, required this.location})
      : name = name ?? DateTime.now().toString(),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EntryPageState();
  }
}

class EntryPageState extends State<EntryPage> {
  final QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0.0);

  List<Message> messages = [];
  void moveToMessages() {
    var text = _controller.document.toPlainText();
    if (text.isEmpty) {
      return;
    }
    messages.add(Message(generateUniqueId(),text, 0));
    _controller.document = Document()..insert(0, '');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _focusNode.requestFocus();
        },
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    if (!_controller.document.isEmpty() ||
                        messages.isNotEmpty) {
                      moveToMessages();

                      final entry = Entry(
                          widget.name, DateTime.now(), widget.location, 0.5,
                          content: messages);

                      realm.write(() {
                        realm.add(entry);
                      });
                    }

                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => JournalPage()));

                  },
                  icon: Icon(Icons.arrow_back)),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        moveToMessages();
                      });
                      openaiResponse(messages).then((value) => {

                      

                      });

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        // Scroll to the bottom after the frame is built
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      });

                      //call api
                    },
                    icon: Icon(Icons.speaker_notes)),
                TextButton(
                    onPressed: () {
                      _focusNode.unfocus();
                    },
                    child: Text("Done"))
              ],
            ),
            body: Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                child: Column(children: [
                  Expanded(
                      child: QuillProvider(
                    configurations:
                        QuillConfigurations(controller: _controller),
                    child: Column(
                      children: [
                        Flexible(
                          flex: 1,
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: messages.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Material(child:ListTile(
                              leading:Icon(Icons.person),
                                title: Text(messages[index].content),
                                tileColor:Colors.blue
                              ));
                            },
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            child: QuillEditor.basic(
                              focusNode: _focusNode,
                              readOnly: false, // true for view only mode
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
                ]))));
  }
}
int generateUniqueId() {
  // You can generate a unique ID here using your desired method.
  // For example, you can use the current timestamp as a unique ID.
  return DateTime.now().millisecondsSinceEpoch;
}

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
  final List<Message> messages;
  EntryPage(
      {Key? key, String? name, List<Message>? messages, required this.location})
      : name = name ?? DateTime.now().toString(),
        messages = messages ?? <Message>[],
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

    if (text.length == 1) {
      return;
    }
    realm.write(() {
      messages.add(Message(generateUniqueId(), text, 0));
      _controller.document = Document()..insert(0, '');
    });
  }

  @override
  void initState() {
    super.initState();
    messages = widget.messages;
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

                      sentimental(messages).then((value) {
                      final entry = Entry(
                          widget.name, DateTime.now(), widget.location, value,
                          content: messages);

                      realm.write(() {
                        realm.add(entry, update: true);
                      });


                      }
                      );

                    }

                    Navigator.of(context).push(
                        PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
        return JournalPage();
      },transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },));
                  },
                  icon: Icon(Icons.arrow_back)),
              actions: [
                IconButton(
                    onPressed: () {
                      if (_controller.document.isEmpty()) {
                        return;
                      }
                      setState(() {
                        moveToMessages();
                      });

                      openaiResponse(messages).then((value) => {
                      setState(() {
                      

                      messages.add(Message(generateUniqueId(),value,1));

                                              
                                            })
                      });

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        // Scroll to the bottom after the frame is built
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      });

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
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
                            var icon = messages[index].speaker==0?Icon(Icons.person):Icon(Icons.smart_toy);
                            var color = messages[index].speaker==0?Theme.of(context).primaryColor:Colors.red;
                              return Container(
                                  decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                      colors: [
                                      color
                                            .withOpacity(0.4),
                                        color.withOpacity(0.1)
                                      ],
                                      center: Alignment.center,
                                      focal: Alignment.center,
                                      radius: 10.0,
                                    ),
                                  ),
                                  child: ListTile(
                                    leading: icon, 
                                    title: Text(messages[index].content),
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

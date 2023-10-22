import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:serenity/realm/entry.dart';

String ip = "https://wetca.ca/serenity";
Map<String, dynamic> messageToJson(Message message) {
  return {'role': 'user', 'message': message.content};
}

Map<String, String> headers = {"Content-type": "application/json"};

Future<String> openaiResponse(List<Message> messages) async {
  var payLoad = {
    'messages': messages.map((element) {
      return messageToJson(element);
    }).toList()
  };

  String body = jsonEncode(payLoad);
  final response =
      await http.post(Uri.parse("$ip/openai"), headers: headers, body: body);
      var res = jsonDecode(response.body)["question"];
      print(res);
      return res;
}

Future<double> sentimental(List<Message> messages) async {
  var payLoad = {
    'text': messages.map((element){
      return element.content;

    }
    ).reduce((value, element) => value+element)
  };

  String body = jsonEncode(payLoad);
  final response =
      await http.post(Uri.parse("$ip/sentiment"), headers: headers, body: body);
      var res= jsonDecode(response.body)[""];
      double score = res["sentiment_score"];
      double magnitude = res["sentiment_magnitude"];
      return score;
}


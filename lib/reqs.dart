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
      var res = jsonDecode(response.body)["ai_response"];
      print(res);
      return res;
}

// Future<String> register(String firstName, String middleName, String lastName,
//     String email, String phoneNo, bool accept) async {
//   String body = jsonEncode({
//     'email': email,
//     'firstName': firstName,
//     'middleName': middleName,
//     'lastName': lastName,
//     'phoneNo': phoneNo,
//     'accept': accept
//   });
//   final response = await http.post(Uri.parse("$ip/users/register"),
//       headers: headers, body: body);
//
//   return jsonDecode(response.body)["message"];
// }
//

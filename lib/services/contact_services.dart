import 'dart:convert';
import 'package:contact_manager/models/contact.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

final Uri restAPIURL =
Uri.parse("https://mock-rest-api-server.herokuapp.com/api/v1/user/");

final httpClient = http.Client();
Map<String, String> customHeaders = {
  "Accept": "application/json",
  "Content-Type": "application/json;charset=UTF-8"
};

Future<List<dynamic>> getContact(String uid) async {
  var result = await http.get(Uri.parse(
      "https://mock-rest-api-server.herokuapp.com/api/v1/user/" + uid));
  return json.decode(result.body)['data'];
}

Future<List<dynamic>> getAllContacts() async {
  var result = await http.get(restAPIURL);
  return json.decode(result.body)['data'];
}



Future addContact(Contact contact) async {
  final Uri restAPIURL =
  Uri.parse("https://mock-rest-api-server.herokuapp.com/api/v1/user");
  http.Response response = await httpClient.post(restAPIURL,
      headers: customHeaders, body: jsonEncode(contact));
  return response.body;
}

Future<dynamic> updateFavorite(
    String uid, String isFavorite) async {
  return await http.put(
    Uri.parse('https://mock-rest-api-server.herokuapp.com/api/v1/user/$uid'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    //need to be changed with bool but some errors with
    body: jsonEncode(<String, String>{
      "id": uid,
      "isFavorite": isFavorite
    }),
  );
}

Future<dynamic> updateContact(
    String uid, first_name, last_name, email, gender, dob, phone) async {
  return await http.put(
    Uri.parse('https://mock-rest-api-server.herokuapp.com/api/v1/user/$uid'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "id": uid,
      "first_name": first_name,
      "last_name": last_name,
      "email": email,
      "gender": gender,
      "date_of_birth": dob,
      "phone_no": phone
    }),
  );
}

Future<Response> deleteContact(String id) async {
  final http.Response response = await http.delete(
    Uri.parse("https://mock-rest-api-server.herokuapp.com/api/v1/user/" + id),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return response;
}

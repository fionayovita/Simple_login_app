import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_app/model/user_model.dart';
import 'package:http/http.dart' as http;

String _dataUserURL =
    'https://firestore.googleapis.com/v1/projects/loginapp-40d14/databases/(default)/documents/users/';

class ApiService {
  static Future<List<ListUser>> fetchDataUser() async {
    final complete = Completer<List<ListUser>>();
    final idToken = await FirebaseAuth.instance.currentUser!.getIdTokenResult();

    final header = {"authorization": 'Bearer ${idToken.token}'};
    try {
      final resp = await http.get(Uri.parse(_dataUserURL), headers: header);

      if (resp.statusCode == 200) {
        final decode = json.decode(resp.body);
        final docs = decode['documents'];
        final data = userModelFromJson(docs);
        complete.complete(data);
        return data;
        // _complete.complete(_data);
      }
    } catch (exc) {
      complete.complete([]);
      complete.completeError(<List<ListUser>>[]);
      throw Exception('Failed to load userresult');
    }

    return complete.future;
  }
}

import 'dart:convert';
import 'package:codemydotcom/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Methods extends ChangeNotifier {
  final String baseUrl = '';
  var client = http.Client();
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };
  Future post(String api, User object) async {
    var url = Uri.parse(baseUrl + api);
    var payload = jsonEncode(object);
    var res = await client.post(
      url,
      headers: headers,
      body: payload,
    );
    debugPrint('Post Status: ${res.statusCode.toString()}');
  }

  Future<List<User>?> get(String api) async {
    var url = Uri.parse(baseUrl + api);
    var res = await client.get(url, headers: headers);
    debugPrint('Get Status: ${res.statusCode.toString()}');
    if (res.statusCode == 200) {
      var json = res.body;
      return userFromJson(json);
    } else {
      debugPrint(res.statusCode.toString());
    }
    return [];
  }

  Future put(String api, User object) async {
    var url = Uri.parse(baseUrl + api);
    String payload = jsonEncode(object);
    var res = await client.put(url, headers: headers, body: payload);
    debugPrint('Put Status: ${res.statusCode.toString()}');
  }

  Future del(String api) async {
    var url = Uri.parse(baseUrl + api);
    var res = await client.delete(url, headers: headers);
    debugPrint('Delete Status: ${res.statusCode.toString()}');
  }
}

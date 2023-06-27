import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => UserService(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<UserService>(context, listen: false).getUsers();
    return Scaffold(
      body: Consumer<UserService>(
        builder: (context, service, child) {
          if (service.users == null) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: service.users!.length,
            itemBuilder: (context, index) {
              return Text(service.users![index].name);
            },
          );
        },
      ),
    );
  }
}

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
    );
  }
}

class UserService with ChangeNotifier {
  List<User>? users;

  Future<void> getUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      List<User> users = json.map((e) => User.fromJson(e)).toList();
      this.users = users;
      notifyListeners();
    } else {
      throw Exception('Failed to load users');
    }
  }
}

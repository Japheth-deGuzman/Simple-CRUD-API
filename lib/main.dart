import 'package:codemydotcom/provider/data_class.dart';
import 'package:codemydotcom/screens/hompage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<DataClass>(
    child: const MyApp(),
    create: (_) => DataClass(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

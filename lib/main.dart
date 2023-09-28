import 'package:flutter/material.dart';
import 'package:flutter_beginer/pages/todo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TodoPage(),
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}

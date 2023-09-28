import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController inputController = TextEditingController();
  String name = "";
  void _updateGreeting() {
    setState(() {
      name =
          "Hello ${inputController.text.toUpperCase().substring(0, 1)}${inputController.text.toLowerCase().substring(1)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Say hello"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: inputController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Type your name"),
              ),
            ),
            ElevatedButton(
              onPressed: _updateGreeting,
              child: const Text(
                "Click me",
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}

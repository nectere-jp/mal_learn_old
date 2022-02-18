import 'package:flutter/material.dart';

void main() async {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mal Learn",
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const Scaffold(
        body: Center(child: Text('hello')),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class HelloWorldResponse {
  final String message;

  HelloWorldResponse({required this.message});

  factory HelloWorldResponse.fromJson(Map<String, dynamic> json) {
    return HelloWorldResponse(
      message: json['message'],
    );
  }
}

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final helloWorld = useState("");
    useEffect(() {
      (() async {
        final url = Uri.parse(
            "https://gjwyot50al.execute-api.ap-northeast-1.amazonaws.com/dev/greeting");
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final bodyJson = json.decode(response.body);
          final greeting = HelloWorldResponse.fromJson(bodyJson).message;
          helloWorld.value = greeting;
        } else {
          debugPrint(response.body.toString());
        }
      })();
      return;
    }, []);
    return MaterialApp(
      title: 'Hello, World!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: helloWorld.value),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.title,
            ),
          ],
        ),
      ),
    );
  }
}

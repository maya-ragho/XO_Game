import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      //color: Colors.blueAccent,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: GameApp()
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/home.dart';
import 'pages/user_profile.dart';

void main() {
  ErrorWidget.builder=(FlutterErrorDetails details) {
return const Center(
child: SizedBox(
height: 100,
width: 100,
child: CupertinoActivityIndicator())); // SizedBox, Center
  };




  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: home()
    );
  }
}

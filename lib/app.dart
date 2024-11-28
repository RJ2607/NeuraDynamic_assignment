import 'package:flutter/material.dart';
import 'package:flutter_assignment/Views/Home/homePage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: HomePage(),
    );
  }
}

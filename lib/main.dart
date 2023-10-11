//import 'package:f1/Api7.dart';
//import 'package:f1/SixthApi.dart';
//import 'package:f1/fifthapi.dart';
//import 'package:f1/fourthapi.dart';
//import 'package:f1/secondapi.dart';
//import 'package:f1/thirdapi.dart';
import 'package:f1/View/splash_screen.dart';
import 'package:flutter/material.dart';
//import 'package:f1/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Api",
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      //home: const HomePage(),
      //home: const SecondApi(),
      //home: const ThirdApi(),
      //home: const FourthApi(),
      //home: const FifthApi(),
      //home: const SixthApi(),
      //home: const SeventhApi(),
      home: const SplashScreen(),
    );
  }
}

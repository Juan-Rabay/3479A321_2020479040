import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Logger logger = Logger();
    logger.d("Logger is working!");

    return MaterialApp(
      title: 'Mi Lab Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
        fontFamily: 'GreatVibes', 
      ),
      home: const MyHomePage(title: 'Mi primer proyecto'),
    );
  }
}

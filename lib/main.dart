import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'providers/app_data.dart';
import 'pages/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppData>(
      create: (_) => AppData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Logger logger = Logger();
    logger.d("Logger funcionando!");

    return MaterialApp(
      title: 'Mi Lab Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
        fontFamily: 'GreatVibes',
      ),
      home: const MyHomePage(title: 'Mi proyecto'),
    );
  }
}

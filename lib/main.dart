import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_data.dart';
import 'pages/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Labs',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.amber),
      home: const MyHomePage(title: 'Mi proyecto'),
    );
  }
}

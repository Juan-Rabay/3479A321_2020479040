import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'list_content_page.dart';
import 'about_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String iconPath = 'assets/icons/my_icon.svg';

  final Logger logger = Logger();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    logger.d("Incremented counter to $_counter");
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
    logger.d("Decremented counter to $_counter");
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
    logger.d("Reset counter to $_counter");
  }

  void _navigateToAnotherPage() {
    if (_counter % 2 == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ListContentPage()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AboutPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  '¡Bienvenido a Flutter',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Flutter es un framework de UI de código abierto para crear aplicaciones.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SvgPicture.asset('assets/icons/my_icon.svg', width: 100, height: 100),
                const SizedBox(height: 20),
                Text(
                  'Contador: $_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: _decrementCounter,
                      icon: const Icon(Icons.remove),
                      tooltip: 'Restar',
                    ),
                    IconButton(
                      onPressed: _resetCounter,
                      icon: const Icon(Icons.refresh),
                      tooltip: 'Reiniciar',
                    ),
                    IconButton(
                      onPressed: _incrementCounter,
                      icon: const Icon(Icons.add),
                      tooltip: 'Sumar',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _navigateToAnotherPage,
                  child: const Text('Ir a otra pantalla'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

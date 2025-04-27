import 'package:flutter/material.dart';
import 'about_page.dart';

class ListContentPage extends StatelessWidget {
  const ListContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'jajaj no',
      'hay ',
      'contenido por',
      'ahora',
      'lo siento',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Contenido'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(items[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AboutPage()),
          );
        },
        child: const Icon(Icons.info),
        tooltip: 'Ir a Sobre',
      ),
    );
  }
}

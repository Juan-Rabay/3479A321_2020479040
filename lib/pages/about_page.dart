import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'home_page.dart';
import '../providers/app_data.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logger = Logger();
    final appData = context.watch<AppData>();
    final nameController = TextEditingController(text: appData.username);

    return Scaffold(
      appBar: AppBar(title: const Text('Sobre')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Edita tu nombre de usuario y la opción de reiniciar:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            // 1) TextField para cambiar username
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre de usuario',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                appData.setUsername(value);
                logger.d('USERNAME changed to $value');
              },
            ),
            const SizedBox(height: 20),

            // 2) Switch para permitir o no el reset
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Permitir reiniciar contador'),
                Switch(
                  value: appData.allowReset,
                  onChanged: (val) {
                    appData.toggleReset(val);
                    logger.d('allowReset changed to $val');
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),

            // 3) Botón para volver (pop)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Volver a Home'),
            ),
          ],
        ),
      ),
    );
  }
}

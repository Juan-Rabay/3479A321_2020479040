import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

import '../providers/app_data.dart';

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logger = Logger();
    final appData = context.watch<AppData>();
    final nameController = TextEditingController(text: appData.username);

    return Scaffold(
      appBar: AppBar(title: const Text('Preferencias')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Nombre de usuario',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ingresa tu nombre:',
              ),
              onChanged: (val) {
                appData.setUsername(val);
                logger.d('USERNAME changed to $val');
              },
            ),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Permitir reiniciar contador',
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                  value: appData.allowReset,
                  onChanged: (val) {
                    appData.toggleReset(val);
                    logger.d('allowReset changed to $val');
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Volver a Home'),
            ),
          ],
        ),
      ),
    );
  }
}

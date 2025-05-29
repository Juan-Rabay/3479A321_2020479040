
import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/preferences_page.dart';
import '../pages/activities_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: Colors.amber),
          child: Text('Menú', style: TextStyle(fontSize: 24, color: Colors.white)),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MyHomePage(title: 'Mi proyecto')),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Preferencias'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PreferencesPage()),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.list),
          title: const Text('Actividades'),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ActivitiesPage()),
          ),
        ),
      ]),
    );
  }
}

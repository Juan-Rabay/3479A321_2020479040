import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../providers/app_data.dart';
import '../widgets/app_drawer.dart';
import 'about_page.dart';
import 'list_content_page.dart';
import 'preferences_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    logger.d('initState: widget insertado en el árbol');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.d('didChangeDependencies: dependencias cambiaron o se inicializaron');
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.d('didUpdateWidget: widget reconstruido con nuevas props');
  }

  @override
  void deactivate() {
    logger.d('deactivate: HomePage será removido del árbol');
    super.deactivate();
  }

  @override
  void dispose() {
    logger.d('dispose: HomePage destruido permanentemente');
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    logger.d('reassemble: hot reload ejecutado');
  }

  void _navigate(BuildContext context, bool replacement) {
    final appData = context.read<AppData>();
    final page = (appData.counter % 2 == 0)
        ? const ListContentPage()
        : const AboutPage();

    if (replacement) {
      logger.d('BUTTON: pushReplacement ${page.runtimeType}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => page),
      );
    } else {
      logger.d('BUTTON: push ${page.runtimeType}');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => page),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appData = context.watch<AppData>();
    logger.d('build: contador=${appData.counter}, allowReset=${appData.allowReset}');

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text('¡Bienvenido, ${appData.username}!',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              const Text(
                'Flutter es un framework de UI de código abierto para crear apps.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              SvgPicture.asset('assets/icons/my_icon.svg',
                  width: 100, height: 100),
              const SizedBox(height: 20),

              Text('Contador: ${appData.counter}',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),

              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                IconButton(
                  onPressed: () {
                    appData.decrementCounter();
                    logger.d('contador decrementado');
                  },
                  icon: const Icon(Icons.remove),
                ),
                if (appData.allowReset)
                  IconButton(
                    onPressed: () {
                      appData.resetCounter();
                      logger.d('contador reiniciado');
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                IconButton(
                  onPressed: () {
                    appData.incrementCounter();
                    logger.d('contador incrementado');
                  },
                  icon: const Icon(Icons.add),
                ),
              ]),
              const SizedBox(height: 20),

              GestureDetector(
                onTap: () => _navigate(context, false),
                onLongPress: () => _navigate(context, true),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    'Navegar',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const PreferencesPage()),
                ),
                child: const Text('Preferencias'),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

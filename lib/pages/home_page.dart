import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../providers/app_data.dart';
import 'about_page.dart';
import 'list_content_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() {
    Logger().d('createState: creando estado para MyHomePage');
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    logger.d('initState: widget insertado en el árbol por primera vez');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.d(
      'didChangeDependencies: dependencias cambiaron o se inicializaron',
    );
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.d(
      'didUpdateWidget: MyHomePage se reconstruyó con nuevas propiedades',
    );
  }

  @override
  void deactivate() {
    logger.d('deactivate: el widget será removido del árbol');
    super.deactivate();
  }

  @override
  void dispose() {
    logger.d('dispose: el widget fue destruido permanentemente');
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    logger.d('reassemble: la aplicación hizo hot reload');
  }

  void _navigate(BuildContext context, bool replace) {
    final appData = context.read<AppData>();
    final Widget page = (appData.counter % 2 == 0)
        ? const ListContentPage()
        : const AboutPage();

    if (replace) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => page),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => page),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appData = context.watch<AppData>();
    logger.d('build: dibujando widget - mounted: $mounted');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '¡Bienvenido, ${appData.username}!',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Flutter es un framework de UI de código abierto para crear aplicaciones.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SvgPicture.asset(
                  'assets/icons/my_icon.svg',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                Text(
                  'Contador: ${appData.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        appData.decrementCounter();
                        logger.d('setState: contador decrementado');
                      },
                      icon: const Icon(Icons.remove),
                      tooltip: 'Restar',
                    ),
                    if (appData.allowReset)
                      IconButton(
                        onPressed: () {
                          appData.resetCounter();
                          logger.d('setState: contador reiniciado');
                        },
                        icon: const Icon(Icons.refresh),
                        tooltip: 'Reiniciar',
                      ),
                    IconButton(
                      onPressed: () {
                        appData.incrementCounter();
                        logger.d('setState: contador incrementado');
                      },
                      icon: const Icon(Icons.add),
                      tooltip: 'Sumar',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _navigate(context, false),
                  onLongPress: () => _navigate(context, true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Ir a otra pantalla',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

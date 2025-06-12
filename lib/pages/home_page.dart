import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'list_content_page.dart';
import 'about_page.dart';
import 'take_picture_screen.dart';
import 'gallery_screen.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final String iconPath = 'assets/icons/my_icon.svg';
  final Logger logger = Logger();

  String _imageUrl = '';
  CameraDescription? _firstCamera;
  String _lastImagePath = '';

  @override
  void initState() {
    super.initState();
    _initCameras();
  }

  Future<void> _initCameras() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        setState(() => _firstCamera = cameras.first);
        logger.d('Cámara inicial: ${_firstCamera!.name}');
      }
    } catch (e) {
      logger.e('Error al cargar cámaras: $e');
    }
  }

  Future<void> _openCamera() async {
    if (_firstCamera == null) {
      logger.w('No hay cámara disponible');
      return;
    }
    final imagePath = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => TakePictureScreen(camera: _firstCamera!)),
    );
    if (imagePath != null && mounted) {
      setState(() => _lastImagePath = imagePath);
      logger.d('Foto capturada en: $imagePath');
    }
  }

  Future<void> _getNewImage() async {
    final newUrl = 'https://picsum.photos/id/$_counter/250/250';
    try {
      final resp = await http.get(Uri.parse(newUrl));
      if (resp.statusCode == 200) {
        setState(() {
          _imageUrl = newUrl;
          _lastImagePath = '';
        });
        logger.d('Imagen Internet cargada: $_imageUrl');
      } else {
        setState(() => _imageUrl = '');
        logger.w('Picsum status ${resp.statusCode}');
      }
    } catch (e) {
      setState(() => _imageUrl = '');
      logger.e('Error al descargar imagen: $e');
    }
  }

  void _openGallery() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const GalleryScreen()),
    );
  }

  void _incrementCounter() {
    setState(() => _counter++);
    logger.d('Incremented to $_counter');
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() => _counter--);
      logger.d('Decremented to $_counter');
    }
  }

  void _resetCounter() {
    setState(() => _counter = 0);
    logger.d('Reset to $_counter');
  }

  void _navigate() {
    final next = (_counter % 2 == 0)
        ? const ListContentPage()
        : const AboutPage();
    Navigator.push(context, MaterialPageRoute(builder: (_) => next));
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (_lastImagePath.isNotEmpty) {
      imageWidget = Image.file(
        File(_lastImagePath),
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
      );
    } else if (_imageUrl.isNotEmpty) {
      imageWidget = Image.network(
        _imageUrl,
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Center(
          child: Text('Error al cargar imagen', style: TextStyle(color: Colors.red)),
        ),
      );
    } else {
      imageWidget = const SizedBox(
        width: double.infinity,
        height: 250,
        child: Center(
          child: Text('No hay imagen', style: TextStyle(color: Colors.black54)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '¡Bienvenido a Flutter!',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Usa Internet, Cámara o Galería para imágenes.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  SvgPicture.asset(iconPath, width: 80, height: 80),
                  const SizedBox(height: 16),
                  Text('Contador: $_counter',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: _decrementCounter, icon: const Icon(Icons.remove)),
                      IconButton(onPressed: _resetCounter,   icon: const Icon(Icons.refresh)),
                      IconButton(onPressed: _incrementCounter, icon: const Icon(Icons.add)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Wrap para evitar overflow
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton(onPressed: _getNewImage,   child: const Text('Internet')),
                      ElevatedButton(onPressed: _openCamera,     child: const Text('Cámara')),
                      ElevatedButton(onPressed: _openGallery,    child: const Text('Galería')),
                      ElevatedButton(onPressed: _navigate,       child: const Text('Ir a otra pantalla')),
                    ],
                  ),

                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: imageWidget,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

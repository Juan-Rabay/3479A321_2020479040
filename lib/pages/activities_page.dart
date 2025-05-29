import 'package:flutter/material.dart';
import '../entity/activity.dart';
import '../services/database_helper.dart';
import 'package:logger/logger.dart';
import '../widgets/app_drawer.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});
  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  final dbHelper = DatabaseHelper.instance;
  final logger = Logger();
  List<Activity> _activities = [];

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  Future<void> _refreshList() async {
    final list = await dbHelper.getAllActivities();
    setState(() => _activities = list);
    logger.d('Loaded ${list.length} activities');
  }

  Future<void> _addActivity() async {
    final now = DateTime.now();
    final a = Activity(date: now, name: 'Acción @ ${now.hour}:${now.minute}');
    await dbHelper.insertActivity(a);
    await _refreshList();
  }

  Future<void> _deleteActivity(int id) async {
    await dbHelper.deleteActivity(id);
    await _refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),          // 2) Usa tu Drawer aquí
      appBar: AppBar(title: const Text('Actividades')),
      body: ListView.builder(
        itemCount: _activities.length,
        itemBuilder: (_, i) {
          final a = _activities[i];
          return ListTile(
            title: Text(a.name),
            subtitle: Text(a.date.toLocal().toString()),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteActivity(a.id!),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addActivity,
        child: const Icon(Icons.add),
      ),
    );
  }
}

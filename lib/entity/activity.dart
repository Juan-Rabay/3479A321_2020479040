class Activity {
  final int? id;
  final DateTime date;
  final String name;

  Activity({this.id, required this.date, required this.name});

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date.toIso8601String(),
        'name': name,
      };

  factory Activity.fromMap(Map<String, dynamic> m) => Activity(
        id: m['id'] as int?,
        date: DateTime.parse(m['date'] as String),
        name: m['name'] as String,
      );
}

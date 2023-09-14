import 'package:uuid/uuid.dart';

class Task {
  final String id;
  final String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false}) : id = const Uuid().v4();
}

import 'package:equatable/equatable.dart';
import '../../utils/utils.dart';

class Task extends Equatable {
  final String? id;
  final String title;
  final String note;
  final TaskCategory category;
  final String time;
  final String date;
  final bool isCompleted;
  final String userId;

  const Task({
    this.id,
    required this.title,
    required this.category,
    required this.time,
    required this.date,
    required this.note,
    required this.isCompleted,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      TaskKeys.id: id,
      TaskKeys.title: title,
      TaskKeys.note: note ?? '',
      TaskKeys.category: category.name,
      TaskKeys.time: time,
      TaskKeys.date: date,
      TaskKeys.isCompleted: isCompleted ? 1 : 0,
      TaskKeys.userId: userId,
    };
  }

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(
      id: map[TaskKeys.id]?.toString(),
      title: map[TaskKeys.title],
      note: map[TaskKeys.note] ?? '',
      category: TaskCategory.stringToTaskCategory(map[TaskKeys.category].toString()),
      time: map[TaskKeys.time],
      date: map[TaskKeys.date],
      isCompleted: map[TaskKeys.isCompleted] == 1,
      userId: map[TaskKeys.userId].toString(),
    );
  }


  @override
  List<Object?> get props {
    return [
      title,
      note,
      category,
      time,
      date,
      isCompleted,
      userId,
    ];
  }

  Task copyWith({
    String? id,
    String? title,
    String? note,
    TaskCategory? category,
    String? time,
    String? date,
    bool? isCompleted,
    String? userId,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      category: category ?? this.category,
      time: time ?? this.time,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
      userId: userId ?? this.userId,
    );
  }
}

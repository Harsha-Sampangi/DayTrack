import 'package:hive_ce/hive.dart';
import '../core/constants/app_constants.dart';

part 'task_item.g.dart';

/// Task data model — stored in Hive.
///
/// Each task has a title, scheduled time, priority level, and completion state.
/// Priority: 0 = Low, 1 = Medium, 2 = High.
@HiveType(typeId: 2) // AppConstants.taskTypeId
class TaskItem extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late DateTime time;

  /// 0 = Low, 1 = Medium, 2 = High. See [AppConstants.priorityLabels].
  @HiveField(3)
  late int priority;

  @HiveField(4)
  late bool isCompleted;

  @HiveField(5)
  late DateTime createdAt;

  TaskItem({
    required this.id,
    required this.title,
    required this.time,
    this.priority = AppConstants.priorityMedium,
    this.isCompleted = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Human-readable priority label.
  String get priorityLabel => AppConstants.priorityLabels[priority];

  TaskItem copyWith({
    String? id,
    String? title,
    DateTime? time,
    int? priority,
    bool? isCompleted,
  }) {
    return TaskItem(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt,
    );
  }

  @override
  String toString() =>
      'TaskItem(id: $id, title: $title, priority: $priorityLabel, done: $isCompleted)';
}

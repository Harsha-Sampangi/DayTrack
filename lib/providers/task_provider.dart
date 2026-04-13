import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../core/utils/date_utils.dart';
import '../models/task_item.dart';
import '../services/hive_service.dart';
import '../services/notification_service.dart';

/// State management for tasks — CRUD, completion toggle, and grouping.
class TaskProvider extends ChangeNotifier {
  static const _uuid = Uuid();

  List<TaskItem> _tasks = [];

  /// All tasks, sorted by time ascending.
  List<TaskItem> get tasks => _tasks;

  /// Load tasks from Hive into memory.
  void loadTasks() {
    _tasks = HiveService.getAllTasks();
    notifyListeners();
  }

  // ── CRUD ─────────────────────────────────────────────────────────────

  /// Add a new task. Optionally schedules a notification reminder.
  Future<void> addTask({
    required String title,
    required DateTime time,
    int priority = 1,
  }) async {
    final task = TaskItem(
      id: _uuid.v4(),
      title: title,
      time: time,
      priority: priority,
    );

    await HiveService.taskBox.put(task.id, task);
    _tasks.add(task);
    _tasks.sort((a, b) => a.time.compareTo(b.time));
    notifyListeners();

    // Schedule a notification for this task if it's in the future
    if (task.time.isAfter(DateTime.now())) {
      NotificationService.showTaskReminder(
        id: task.time.millisecondsSinceEpoch ~/ 1000,
        taskTitle: task.title,
      );
    }
  }

  /// Delete a task by its ID.
  Future<void> deleteTask(String id) async {
    await HiveService.taskBox.delete(id);
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  /// Toggle the completion status of a task.
  Future<void> toggleComplete(String id) async {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index == -1) return;

    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    await _tasks[index].save(); // Hive saves in-place for HiveObject
    notifyListeners();
  }

  // ── Computed Properties ──────────────────────────────────────────────

  /// Number of incomplete tasks.
  int get pendingCount => _tasks.where((t) => !t.isCompleted).length;

  /// Number of tasks completed today.
  int get completedTodayCount {
    return _tasks
        .where((t) => t.isCompleted && AppDateUtils.isToday(t.time))
        .length;
  }

  /// Total task count.
  int get totalCount => _tasks.length;

  /// Completion percentage (0.0 – 1.0).
  double get completionRate {
    if (_tasks.isEmpty) return 0;
    return _tasks.where((t) => t.isCompleted).length / _tasks.length;
  }

  // ── Grouped Lists ────────────────────────────────────────────────────

  /// Today's tasks (incomplete).
  List<TaskItem> get todayTasks {
    return _tasks
        .where((t) => AppDateUtils.isToday(t.time) && !t.isCompleted)
        .toList();
  }

  /// Overdue tasks (past, incomplete).
  List<TaskItem> get overdueTasks {
    return _tasks
        .where((t) => AppDateUtils.isOverdue(t.time) && !t.isCompleted)
        .toList();
  }

  /// Upcoming tasks (future, incomplete).
  List<TaskItem> get upcomingTasks {
    final now = DateTime.now();
    return _tasks
        .where((t) =>
            !AppDateUtils.isToday(t.time) &&
            t.time.isAfter(now) &&
            !t.isCompleted)
        .toList();
  }

  /// Completed tasks (all).
  List<TaskItem> get completedTasks {
    return _tasks.where((t) => t.isCompleted).toList();
  }
}

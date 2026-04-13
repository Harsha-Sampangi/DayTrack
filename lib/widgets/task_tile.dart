import 'package:flutter/material.dart';
import 'package:personal_life_manager/core/constants/app_colors.dart';
import 'package:personal_life_manager/models/task_item.dart';

/// Task tile matching Figma — CheckCircle/Circle icons, priority color bar with glow.
class TaskTile extends StatelessWidget {
  final TaskItem task;
  final ValueChanged<bool?>? onToggle;
  final VoidCallback? onDelete;

  const TaskTile({
    super.key,
    required this.task,
    this.onToggle,
    this.onDelete,
  });

  Color get _priorityColor {
    switch (task.priority) {
      case 2: return AppColors.priorityHigh;
      case 1: return AppColors.priorityMedium;
      default: return AppColors.priorityLow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onToggle?.call(!task.isCompleted),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          children: [
            // Checkbox icon
            Icon(
              task.isCompleted
                  ? Icons.check_circle_rounded
                  : Icons.circle_outlined,
              color: task.isCompleted
                  ? AppColors.primary
                  : AppColors.textSecondary,
              size: 24,
            ),
            const SizedBox(width: 16),

            // Title + time
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: task.isCompleted
                          ? AppColors.textSecondary
                          : AppColors.textPrimary,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      decorationColor: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatTime(task.time),
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Priority color bar with glow
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: _priorityColor,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: _priorityColor.withOpacity(0.25),
                    blurRadius: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour > 12 ? dt.hour - 12 : dt.hour;
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    final min = dt.minute.toString().padLeft(2, '0');
    return '$hour:$min $period';
  }
}

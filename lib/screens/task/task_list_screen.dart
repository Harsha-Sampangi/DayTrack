import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:personal_life_manager/core/constants/app_colors.dart';
import 'package:personal_life_manager/providers/task_provider.dart';
import 'package:personal_life_manager/widgets/task_tile.dart';
import 'dart:math' as math;

/// Task list matching Figma — progress hero card with circular ring, grouped sections.
class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, provider, _) {
        final completed = provider.completedTasks.length;
        final total = provider.totalCount;
        final pct = total > 0 ? completed / total : 0.0;
        final today = provider.todayTasks;
        final upcoming = provider.upcomingTasks;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Title ─────────────────────────────────────────────────
              const Padding(
                padding: EdgeInsets.fromLTRB(24, 56, 24, 24),
                child: Text(
                  'Tasks',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
              ),

              // ── Progress Hero Card ────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: AppColors.balanceGradient,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Progress',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '$completed',
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '/ $total',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Circular progress ring
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CustomPaint(
                          painter: _ProgressRingPainter(pct),
                          child: Center(
                            child: Text(
                              '${(pct * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ── Today Section ─────────────────────────────────────────
              if (today.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 12),
                  child: Text(
                    'Today',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                ...today.map((task) => Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                      child: TaskTile(
                        task: task,
                        onToggle: (_) => provider.toggleComplete(task.id),
                        onDelete: () => provider.deleteTask(task.id),
                      ),
                    )),
              ],

              // ── Upcoming Section ──────────────────────────────────────
              if (upcoming.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
                  child: const Text(
                    'Upcoming',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                ...upcoming.map((task) => Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                      child: TaskTile(
                        task: task,
                        onToggle: (_) => provider.toggleComplete(task.id),
                        onDelete: () => provider.deleteTask(task.id),
                      ),
                    )),
              ],

              // ── Empty State ───────────────────────────────────────────
              if (provider.tasks.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(48),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(Icons.task_alt_rounded,
                            size: 64, color: AppColors.textHint),
                        const SizedBox(height: 12),
                        const Text('No tasks yet',
                            style: TextStyle(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Custom painter for the circular progress ring with gradient stroke.
class _ProgressRingPainter extends CustomPainter {
  final double progress;
  _ProgressRingPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    // Background ring
    final bgPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..color = Colors.white.withOpacity(0.1);
    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc with gradient
    if (progress > 0) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      final progressPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round
        ..shader = const LinearGradient(
          colors: [AppColors.primary, AppColors.violet],
        ).createShader(rect);
      canvas.drawArc(
        rect,
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter old) =>
      old.progress != progress;
}

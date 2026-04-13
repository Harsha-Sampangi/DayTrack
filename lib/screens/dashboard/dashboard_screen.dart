import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:personal_life_manager/core/constants/app_colors.dart';
import 'package:personal_life_manager/core/utils/currency_utils.dart';
import 'package:personal_life_manager/providers/expense_provider.dart';
import 'package:personal_life_manager/providers/income_provider.dart';
import 'package:personal_life_manager/providers/task_provider.dart';
import 'package:personal_life_manager/widgets/expense_tile.dart';

/// Dashboard matching the Figma design:
/// - "Welcome back" + date header
/// - 2 top cards (Expense red, Income green)
/// - 1 full-width Balance card (indigo gradient)
/// - Recent Transactions list
/// - Today's Tasks preview
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<ExpenseProvider, IncomeProvider, TaskProvider>(
      builder: (context, expenses, income, tasks, _) {
        final balance = income.todayTotal - expenses.todayTotal;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header: "Welcome back" + date ──────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 56, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome back',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formattedDate(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // ── 2 Top Cards (Expense + Income) ─────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Row(
                  children: [
                    // Today's Expense card
                    Expanded(
                      child: _HeroCard(
                        label: "Today's Expense",
                        value: CurrencyUtils.format(expenses.todayTotal),
                        icon: Icons.trending_down_rounded,
                        gradient: AppColors.expenseGradient,
                        accentColor: AppColors.expense,
                        progress: expenses.spendingLimit.hasDailyLimit
                            ? (expenses.todayTotal /
                                    expenses.spendingLimit.dailyLimit)
                                .clamp(0.0, 1.0)
                            : null,
                        progressLabel: expenses.spendingLimit.hasDailyLimit
                            ? '${((expenses.todayTotal / expenses.spendingLimit.dailyLimit) * 100).toStringAsFixed(0)}% of daily budget'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Today's Income card
                    Expanded(
                      child: _HeroCard(
                        label: "Today's Income",
                        value: CurrencyUtils.format(income.todayTotal),
                        icon: Icons.trending_up_rounded,
                        gradient: AppColors.incomeGradient,
                        accentColor: AppColors.income,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Full-width Balance Card ────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
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
                          const Row(
                            children: [
                              Text(
                                'Balance',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                CurrencyUtils.format(balance.abs()),
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              if (income.todayTotal > 0) ...[
                                const SizedBox(width: 8),
                                Text(
                                  balance >= 0 ? '+${((balance / income.todayTotal) * 100).toStringAsFixed(0)}%' : '',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.income,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        Icons.account_balance_wallet_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),

              // ── Recent Transactions ────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Transactions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              if (expenses.expenses.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: const Center(
                      child: Text(
                        'No transactions yet',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                  ),
                )
              else
                ...expenses.recentExpenses().map((e) => Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                      child: ExpenseTile(expense: e),
                    )),

              // ── Today's Tasks ──────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Today's Tasks",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '${tasks.completedTodayCount}/${tasks.todayTasks.length}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              if (tasks.todayTasks.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: const Center(
                      child: Text(
                        'No tasks for today',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ),
                  ),
                )
              else
                ...tasks.todayTasks.take(3).map((task) => Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                      child: _TaskPreviewTile(
                        title: task.title,
                        completed: task.isCompleted,
                        onTap: () => tasks.toggleComplete(task.id),
                      ),
                    )),
            ],
          ),
        );
      },
    );
  }

  String _formattedDate() {
    final now = DateTime.now();
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    const months = ['January', 'February', 'March', 'April', 'May', 'June',
                     'July', 'August', 'September', 'October', 'November', 'December'];
    return '${days[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}, ${now.year}';
  }
}

/// Hero stat card with gradient background.
class _HeroCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final LinearGradient gradient;
  final Color accentColor;
  final double? progress;
  final String? progressLabel;

  const _HeroCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.gradient,
    required this.accentColor,
    this.progress,
    this.progressLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              Icon(icon, size: 16, color: accentColor),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          if (progress != null) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress!,
                backgroundColor: Colors.black.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation(accentColor),
                minHeight: 6,
              ),
            ),
            if (progressLabel != null) ...[
              const SizedBox(height: 6),
              Text(
                progressLabel!,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

/// Simple task preview tile for dashboard.
class _TaskPreviewTile extends StatelessWidget {
  final String title;
  final bool completed;
  final VoidCallback? onTap;

  const _TaskPreviewTile({
    required this.title,
    required this.completed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: completed ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: completed
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  width: 2,
                ),
              ),
              child: completed
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: completed
                      ? AppColors.textSecondary
                      : AppColors.textPrimary,
                  decoration:
                      completed ? TextDecoration.lineThrough : null,
                  decorationColor: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

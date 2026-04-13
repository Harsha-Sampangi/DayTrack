import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:personal_life_manager/core/constants/app_colors.dart';
import 'package:personal_life_manager/core/constants/app_strings.dart';
import 'package:personal_life_manager/core/utils/currency_utils.dart';
import 'package:personal_life_manager/providers/expense_provider.dart';
import 'package:personal_life_manager/widgets/expense_tile.dart';

/// Expense list matching Figma — red hero card, filter pills, icon-prefixed tiles.
class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  int _activeFilter = 0; // 0=Daily, 1=Weekly, 2=Monthly
  static const _filters = ['Daily', 'Weekly', 'Monthly'];

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, _) {
        final displayTotal = _activeFilter == 0
            ? provider.todayTotal
            : _activeFilter == 1
                ? provider.weeklyTotal
                : provider.monthlyTotal;

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
                  'Expenses',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
              ),

              // ── Hero Card — Total Spending ────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.expense.withOpacity(0.2),
                        AppColors.expense.withOpacity(0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.cardBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.expense.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.trending_down_rounded,
                                color: AppColors.expense, size: 20),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Total Spending',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            CurrencyUtils.format(displayTotal),
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _activeFilter == 0
                                ? 'today'
                                : _activeFilter == 1
                                    ? 'this week'
                                    : 'this month',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ── Filter Pills ──────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: List.generate(_filters.length, (i) {
                    final isActive = i == _activeFilter;
                    return Padding(
                      padding: EdgeInsets.only(right: i < 2 ? 8 : 0),
                      child: GestureDetector(
                        onTap: () => setState(() => _activeFilter = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.primary
                                : AppColors.card,
                            borderRadius: BorderRadius.circular(12),
                            border: isActive
                                ? null
                                : Border.all(color: AppColors.cardBorder),
                          ),
                          child: Text(
                            _filters[i],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isActive
                                  ? Colors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),

              // ── Expense List ──────────────────────────────────────────
              if (provider.expenses.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(Icons.receipt_long_rounded,
                            size: 64, color: AppColors.textHint),
                        const SizedBox(height: 12),
                        const Text(
                          'No expenses yet',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ...provider.expenses.map((expense) => Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                      child: ExpenseTile(
                        expense: expense,
                        onDelete: () {
                          provider.deleteExpense(expense.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(AppStrings.expenseDeleted)),
                          );
                        },
                      ),
                    )),
            ],
          ),
        );
      },
    );
  }
}

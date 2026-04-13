import 'package:flutter/material.dart';
import 'package:personal_life_manager/core/constants/app_colors.dart';
import 'package:personal_life_manager/core/utils/currency_utils.dart';
import 'package:personal_life_manager/core/utils/date_utils.dart';
import 'package:personal_life_manager/models/expense.dart';

/// Expense tile matching Figma — 48px icon container, name + date, amount + category.
class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final VoidCallback? onDelete;

  const ExpenseTile({super.key, required this.expense, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                _emojiForCategory(expense.category),
                style: const TextStyle(fontSize: 22),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Name + date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.category,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  AppDateUtils.timeAgo(expense.date),
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Amount + category
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '-${CurrencyUtils.format(expense.amount)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.expense,
                ),
              ),
              if (expense.notes.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  expense.notes,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _emojiForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'food': return '🍕';
      case 'travel': return '🚗';
      case 'shopping': return '🛒';
      case 'college': return '📚';
      case 'housing': return '🏠';
      case 'health': return '❤️';
      case 'tech': return '📱';
      case 'entertainment': return '🎬';
      default: return '💰';
    }
  }
}

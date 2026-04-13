import 'package:flutter/material.dart';
import 'package:personal_life_manager/core/constants/app_colors.dart';
import 'package:personal_life_manager/core/utils/currency_utils.dart';
import 'package:personal_life_manager/core/utils/date_utils.dart';
import 'package:personal_life_manager/models/income.dart';

/// Income tile matching Figma — green tinted icon, source on right.
class IncomeTile extends StatelessWidget {
  final Income income;
  final VoidCallback? onDelete;

  const IncomeTile({super.key, required this.income, this.onDelete});

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
              color: AppColors.income.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _iconForSource(income.source),
              color: AppColors.income,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),

          // Name + date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  income.source,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  AppDateUtils.formatDate(income.date),
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Amount + source
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '+${CurrencyUtils.format(income.amount)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.income,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                income.source,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _iconForSource(String source) {
    switch (source.toLowerCase()) {
      case 'part-time': return Icons.work_outline_rounded;
      case 'freelance': return Icons.laptop_mac_rounded;
      case 'stipend': return Icons.school_rounded;
      case 'allowance': return Icons.card_giftcard_rounded;
      default: return Icons.account_balance_wallet_rounded;
    }
  }
}

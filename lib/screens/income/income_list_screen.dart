import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:personal_life_manager/core/constants/app_colors.dart';
import 'package:personal_life_manager/core/constants/app_strings.dart';
import 'package:personal_life_manager/core/utils/currency_utils.dart';
import 'package:personal_life_manager/providers/income_provider.dart';
import 'package:personal_life_manager/widgets/income_tile.dart';

/// Income list matching Figma — green hero card with progress bar, icon-prefixed tiles.
class IncomeListScreen extends StatelessWidget {
  const IncomeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IncomeProvider>(
      builder: (context, provider, _) {
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
                  'Income',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
              ),

              // ── Hero Card — Total Income ──────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.income.withOpacity(0.2),
                        AppColors.income.withOpacity(0.1),
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
                              color: AppColors.income.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.trending_up_rounded,
                                color: AppColors.income, size: 20),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Total Income',
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
                            CurrencyUtils.format(provider.monthlyTotal),
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'this month',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      // Progress bar
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: 0.75,
                                backgroundColor: Colors.black.withOpacity(0.2),
                                valueColor: const AlwaysStoppedAnimation(
                                    AppColors.income),
                                minHeight: 8,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            '75% of goal',
                            style: TextStyle(
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
              const SizedBox(height: 20),

              // ── Income List ───────────────────────────────────────────
              if (provider.incomes.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(48),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(Icons.account_balance_wallet_outlined,
                            size: 64, color: AppColors.textHint),
                        const SizedBox(height: 12),
                        const Text('No income entries yet',
                            style: TextStyle(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                )
              else
                ...provider.incomes.map((income) => Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                      child: IncomeTile(
                        income: income,
                        onDelete: () {
                          provider.deleteIncome(income.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(AppStrings.incomeDeleted)),
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

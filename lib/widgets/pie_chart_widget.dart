import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:personal_life_manager/core/constants/app_colors.dart';

/// Donut pie chart matching the Figma analytics design.
/// Shows category-colored ring with total in center + legend below.
class PieChartWidget extends StatelessWidget {
  final Map<String, double> data;

  const PieChartWidget({super.key, required this.data});

  static const _colorMap = {
    'Food': AppColors.catFood,
    'Travel': AppColors.catTravel,
    'Shopping': AppColors.catShopping,
    'College': AppColors.catCollege,
    'Housing': AppColors.catHousing,
    'Health': AppColors.catHealth,
    'Tech': AppColors.catTech,
    'Others': AppColors.catOthers,
  };

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text('No data yet', style: TextStyle(color: AppColors.textSecondary)),
        ),
      );
    }

    final total = data.values.fold(0.0, (sum, v) => sum + v);

    return Column(
      children: [
        // Donut chart with total in center
        SizedBox(
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 4,
                  centerSpaceRadius: 60,
                  startDegreeOffset: -90,
                  sections: data.entries.map((e) {
                    final color = _colorMap[e.key] ?? AppColors.catOthers;
                    return PieChartSectionData(
                      value: e.value,
                      color: color,
                      radius: 20,
                      showTitle: false,
                    );
                  }).toList(),
                ),
              ),
              // Total in center
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '₹${total.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Legend with glow dots + percentages
        ...data.entries.map((e) {
          final color = _colorMap[e.key] ?? AppColors.catOthers;
          final pct = total > 0 ? (e.value / total * 100).round() : 0;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  e.key,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  '₹${e.value.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$pct%',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

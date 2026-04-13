import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// Maps expense categories to icons and colors.
class CategoryIcon extends StatelessWidget {
  final String category;
  final double size;

  const CategoryIcon({
    super.key,
    required this.category,
    this.size = 36,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(_icon, color: _color, size: size * 0.5),
    );
  }

  IconData get _icon {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.restaurant_rounded;
      case 'travel':
        return Icons.directions_car_rounded;
      case 'shopping':
        return Icons.shopping_bag_rounded;
      case 'college':
        return Icons.school_rounded;
      case 'others':
      default:
        return Icons.more_horiz_rounded;
    }
  }

  Color get _color {
    switch (category.toLowerCase()) {
      case 'food':
        return AppColors.catFood;
      case 'travel':
        return AppColors.catTravel;
      case 'shopping':
        return AppColors.catShopping;
      case 'college':
        return AppColors.catCollege;
      case 'others':
      default:
        return AppColors.catOthers;
    }
  }

  /// Static helper to get color for a category (used in charts).
  static Color colorFor(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return AppColors.catFood;
      case 'travel':
        return AppColors.catTravel;
      case 'shopping':
        return AppColors.catShopping;
      case 'college':
        return AppColors.catCollege;
      case 'others':
      default:
        return AppColors.catOthers;
    }
  }
}

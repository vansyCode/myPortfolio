import 'package:flutter/material.dart';
import '../utils/app_constants.dart';

class SkillChip extends StatelessWidget {
  final String skill;

  const SkillChip({Key? key, required this.skill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spacingMedium,
        vertical: AppSizes.spacingSmall,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 1),
      ),
      child: Text(
        skill,
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
          fontSize: AppFontSizes.body,
        ),
      ),
    );
  }
}

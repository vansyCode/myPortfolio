import 'package:flutter/material.dart';
import '../utils/app_constants.dart';

class InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const InfoItem({Key? key, required this.label, required this.value})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.spacingXSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              fontSize: AppFontSizes.body,
            ),
          ),
          SizedBox(width: AppSizes.spacingSmall),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: AppFontSizes.body,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

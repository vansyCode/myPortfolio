import 'package:flutter/material.dart';
import '../utils/app_constants.dart';
import '../painters/grid_background_painter.dart';

class HomeSection extends StatelessWidget {
  final VoidCallback onViewPortfolio;
  final VoidCallback onContactMe;

  const HomeSection({
    Key? key,
    required this.onViewPortfolio,
    required this.onContactMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > AppBreakpoints.tablet;

    return Container(
      height: AppSizes.homeSectionHeight,
      child: Stack(
        children: [
          // Grid Background
          Positioned.fill(
            child: CustomPaint(
              painter: GridBackgroundPainter(
                gridSize: AppSizes.gridSize,
                lineColor: AppColors.gridColor,
              ),
            ),
          ),

          // Main Content
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.horizontalPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildProfileImage(),
                  SizedBox(height: AppSizes.spacingLarge),
                  _buildTitle(isDesktop),
                  SizedBox(height: AppSizes.spacingMedium),
                  _buildSubtitle(),
                  SizedBox(height: AppSizes.spacingExtraLarge),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: AppSizes.profileImageLarge,
      height: AppSizes.profileImageLarge,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(AppAssets.profileImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTitle(bool isDesktop) {
    return Text(
      AppStrings.homeTitle,
      style: TextStyle(
        fontSize: isDesktop
            ? AppFontSizes.titleLarge
            : AppFontSizes.titleMedium,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSubtitle() {
    return Text(
      AppStrings.homeSubtitle,
      style: TextStyle(
        fontSize: AppFontSizes.bodyLarge,
        color: AppColors.textSecondary,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Wrap(
      spacing: AppSizes.spacingMedium,
      runSpacing: AppSizes.spacingSmall,
      alignment: WrapAlignment.center,
      children: [_buildPrimaryButton(), _buildSecondaryButton()],
    );
  }

  Widget _buildPrimaryButton() {
    return ElevatedButton(
      onPressed: onViewPortfolio,
      style:
          ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.buttonHorizontalPadding,
              vertical: AppSizes.buttonVerticalPadding,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
            ),
            elevation: 0,
          ).copyWith(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.hovered)) {
                return AppColors.primaryDark;
              }
              return AppColors.primary;
            }),
          ),
      child: Text(
        AppStrings.viewPortfolioButton,
        style: TextStyle(
          fontSize: AppFontSizes.button,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSecondaryButton() {
    return OutlinedButton(
      onPressed: onContactMe,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: BorderSide(color: AppColors.primary, width: 2),
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.buttonHorizontalPadding,
          vertical: AppSizes.buttonVerticalPadding,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
        ),
      ),
      child: Text(
        AppStrings.contactMeButton,
        style: TextStyle(
          fontSize: AppFontSizes.button,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

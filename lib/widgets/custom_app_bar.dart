import 'package:flutter/material.dart';
import '../utils/app_constants.dart';

class CustomAppBar extends StatelessWidget {
  final String currentSection;
  final String? hoveredNav;
  final Function(String?) onNavHover;
  final Function(String) onNavPressed;

  const CustomAppBar({
    Key? key,
    required this.currentSection,
    required this.hoveredNav,
    required this.onNavHover,
    required this.onNavPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > AppBreakpoints.tablet;
    final isTablet = MediaQuery.of(context).size.width > AppBreakpoints.mobile;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.horizontalPadding,
        vertical: AppSizes.spacingMedium,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildLogo(),
          if (isTablet) ...[
            SizedBox(width: AppSizes.spacingMedium),
            _buildTitle(context),
          ],
          Spacer(),
          if (isDesktop)
            _buildDesktopNavigation()
          else
            _buildMobileNavigation(context),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      ),
      child: Image.asset(AppAssets.logo, fit: BoxFit.contain),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      AppStrings.fullName,
      style: TextStyle(
        fontSize: AppFontSizes.subtitle,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildDesktopNavigation() {
    final navItems = ['Home', 'About', 'Portfolio', 'Contact'];
    return Row(children: navItems.map((item) => _buildNavItem(item)).toList());
  }

  Widget _buildNavItem(String title) {
    final isActive = currentSection == title;
    final isHovered = hoveredNav == title;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.spacingMedium),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => onNavHover(title),
        onExit: (_) => onNavHover(null),
        child: InkWell(
          onTap: () => onNavPressed(title),
          borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.spacingMedium,
              vertical: AppSizes.spacingSmall,
            ),
            decoration: BoxDecoration(
              color: isActive || isHovered
                  ? AppColors.primary.withOpacity(0.85)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
            ),
            child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              style: TextStyle(
                color: isActive || isHovered
                    ? Colors.white
                    : AppColors.textSecondary,
                fontWeight: FontWeight.w500,
                fontSize: AppFontSizes.body,
              ),
              child: Text(title),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNavigation(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.menu, color: AppColors.textPrimary),
      onSelected: onNavPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
      itemBuilder: (context) => [
        _buildPopupMenuItem('Home', Icons.home),
        _buildPopupMenuItem('About', Icons.person),
        _buildPopupMenuItem('Portfolio', Icons.work),
        _buildPopupMenuItem('Contact', Icons.contact_mail),
      ],
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String title, IconData icon) {
    return PopupMenuItem<String>(
      value: title,
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          SizedBox(width: AppSizes.spacingSmall),
          Text(
            title,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: AppFontSizes.body,
            ),
          ),
        ],
      ),
    );
  }
}

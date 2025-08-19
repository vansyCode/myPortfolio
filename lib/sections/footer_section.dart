import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_constants.dart';

class FooterSection extends StatelessWidget {
  final VoidCallback onHomePressed;
  final VoidCallback onAboutPressed;
  final VoidCallback onPortfolioPressed;
  final VoidCallback onContactPressed;

  const FooterSection({
    Key? key,
    required this.onHomePressed,
    required this.onAboutPressed,
    required this.onPortfolioPressed,
    required this.onContactPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.footerBackground,
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.spacingExtraLarge,
        horizontal: AppSizes.horizontalPadding,
      ),
      child: Column(
        children: [
          _buildLogo(),
          SizedBox(height: AppSizes.spacingMedium),
          _buildTagline(),
          SizedBox(height: AppSizes.spacingLarge),
          _buildNavigation(context),
          SizedBox(height: AppSizes.spacingLarge),
          _buildSocialLinks(),
          SizedBox(height: AppSizes.spacingLarge),
          _buildDivider(),
          SizedBox(height: AppSizes.spacingMedium),
          _buildCopyright(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Image.asset(AppAssets.logo, fit: BoxFit.contain),
        ),
        SizedBox(width: AppSizes.spacingSmall),
        Text(
          AppStrings.fullName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: AppFontSizes.subtitle,
          ),
        ),
      ],
    );
  }

  Widget _buildTagline() {
    return Text(
      AppStrings.footerTagline,
      style: TextStyle(
        color: AppColors.footerTextSecondary,
        fontSize: AppFontSizes.body,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildNavigation(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > AppBreakpoints.mobile;

    final navItems = [
      NavItem('Home', onHomePressed),
      NavItem('About', onAboutPressed),
      NavItem('Portfolio', onPortfolioPressed),
      NavItem('Contact', onContactPressed),
    ];

    if (isDesktop) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: navItems.map((item) => _buildNavItem(item)).toList(),
      );
    } else {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: AppSizes.spacingMedium,
        runSpacing: AppSizes.spacingSmall,
        children: navItems.map((item) => _buildNavItem(item)).toList(),
      );
    }
  }

  Widget _buildNavItem(NavItem item) {
    return TextButton(
      onPressed: item.onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.footerTextSecondary,
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.spacingMedium,
          vertical: AppSizes.spacingSmall,
        ),
      ),
      child: Text(
        item.title,
        style: TextStyle(
          fontSize: AppFontSizes.body,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSocialLinks() {
    final socialLinks = [
      SocialLink(
        icon: Icons.facebook,
        url: AppStrings.facebookUrl,
        label: 'Facebook',
      ),
      SocialLink(
        icon: FontAwesomeIcons.linkedin,
        url: AppStrings.linkedinUrl,
        label: 'LinkedIn',
      ),
      SocialLink(
        icon: FontAwesomeIcons.github,
        url: AppStrings.githubUrl,
        label: 'GitHub',
      ),
      SocialLink(
        icon: FontAwesomeIcons.instagram,
        url: AppStrings.instagramUrl,
        label: 'Instagram',
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: socialLinks.map((link) => _buildSocialButton(link)).toList(),
    );
  }

  Widget _buildSocialButton(SocialLink link) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.spacingSmall),
      child: IconButton(
        icon: Icon(link.icon, color: AppColors.footerTextSecondary, size: 24),
        onPressed: () => _launchURL(link.url),
        tooltip: link.label,
        splashRadius: 24,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: AppColors.footerDivider, thickness: 1, height: 1);
  }

  Widget _buildCopyright() {
    return Text(
      AppStrings.copyright,
      style: TextStyle(
        color: AppColors.footerTextTertiary,
        fontSize: AppFontSizes.caption,
        height: 1.6,
      ),
      textAlign: TextAlign.center,
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }
}

// Helper classes
class NavItem {
  final String title;
  final VoidCallback onPressed;

  NavItem(this.title, this.onPressed);
}

class SocialLink {
  final IconData icon;
  final String url;
  final String label;

  SocialLink({required this.icon, required this.url, required this.label});
}

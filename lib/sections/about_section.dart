import 'package:flutter/material.dart';
import '../utils/app_constants.dart';
import '../widgets/skill_chip.dart';
import '../widgets/service_item.dart';
import '../widgets/info_item.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.sectionVerticalPadding,
        horizontal: AppSizes.horizontalPadding,
      ),
      child: Column(
        children: [
          _buildSectionTitle(),
          SizedBox(height: AppSizes.spacingExtraLarge),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Text(
      AppStrings.aboutTitle,
      style: TextStyle(
        fontSize: AppFontSizes.sectionTitle,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > AppBreakpoints.tablet;

        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: _buildProfileSection()),
              SizedBox(width: AppSizes.spacingExtraLarge),
              Expanded(flex: 1, child: _buildSkillsSection()),
            ],
          );
        } else {
          return Column(
            children: [
              _buildProfileSection(),
              SizedBox(height: AppSizes.spacingExtraLarge),
              _buildSkillsSection(),
            ],
          );
        }
      },
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        _buildProfileImage(),
        SizedBox(height: AppSizes.spacingLarge),
        ..._buildPersonalInfo(),
        SizedBox(height: AppSizes.spacingMedium),
        _buildDescription(),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: AppSizes.profileImageMedium,
      height: AppSizes.profileImageMedium,
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

  List<Widget> _buildPersonalInfo() {
    final info = [
      {'label': 'Name:', 'value': AppStrings.fullName},
      {'label': 'Location:', 'value': AppStrings.location},
      {'label': 'Education:', 'value': AppStrings.education},
      {'label': 'University:', 'value': AppStrings.university},
    ];

    return info
        .map((item) => InfoItem(label: item['label']!, value: item['value']!))
        .toList();
  }

  Widget _buildDescription() {
    return Column(
      children: [
        Text(
          'Description',
          style: TextStyle(
            fontSize: AppFontSizes.subtitle,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSizes.spacingSmall),
        Text(
          AppStrings.aboutDescription,
          style: TextStyle(
            fontSize: AppFontSizes.body,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSkillsTitle(),
        SizedBox(height: AppSizes.spacingMedium),
        _buildSkillsGrid(),
        SizedBox(height: AppSizes.spacingExtraLarge),
        _buildServicesTitle(),
        SizedBox(height: AppSizes.spacingMedium),
        _buildServicesList(),
      ],
    );
  }

  Widget _buildSkillsTitle() {
    return Text(
      'Skills & Technologies',
      style: TextStyle(
        fontSize: AppFontSizes.subtitle,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildSkillsGrid() {
    final skills = [
      'Flutter',
      'Dart',
      'UI/UX Design',
      'Firebase',
      'REST API',
      'Git',
      'Provider',
      'Bloc',
    ];

    return Wrap(
      spacing: AppSizes.spacingSmall,
      runSpacing: AppSizes.spacingSmall,
      children: skills.map((skill) => SkillChip(skill: skill)).toList(),
    );
  }

  Widget _buildServicesTitle() {
    return Text(
      'What I Do',
      style: TextStyle(
        fontSize: AppFontSizes.subtitle,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildServicesList() {
    final services = [
      {
        'icon': Icons.phone_android,
        'title': 'Mobile Development',
        'description':
            'Creating cross-platform mobile applications with Flutter for iOS and Android.',
      },
      {
        'icon': Icons.web,
        'title': 'Web Development',
        'description':
            'Building responsive web applications using Flutter for web platform.',
      },
      {
        'icon': Icons.design_services,
        'title': 'UI/UX Design',
        'description':
            'Designing intuitive and beautiful user interfaces with focus on user experience.',
      },
    ];

    return Column(
      children: services
          .map(
            (service) => ServiceItem(
              icon: service['icon'] as IconData,
              title: service['title'] as String,
              description: service['description'] as String,
            ),
          )
          .toList(),
    );
  }
}

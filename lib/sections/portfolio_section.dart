import 'package:flutter/material.dart';
import '../utils/app_constants.dart';
import '../widgets/project_card.dart';
import '../models/project_model.dart';
import '../screens/project_detail_page.dart'; // Import halaman detail proyek

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.sectionVerticalPadding,
        horizontal: AppSizes.horizontalPadding,
      ),
      color: AppColors.backgroundSecondary,
      child: Column(
        children: [
          _buildSectionHeader(),
          SizedBox(height: AppSizes.spacingExtraLarge),
          _buildProjectsGrid(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      children: [
        Text(
          AppStrings.portfolioTitle,
          style: TextStyle(
            fontSize: AppFontSizes.sectionTitle,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSizes.spacingMedium),
        Text(
          AppStrings.portfolioSubtitle,
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

  Widget _buildProjectsGrid(BuildContext context) {
    final projects = _getProjects();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > AppBreakpoints.tablet;

        if (isDesktop) {
          return _buildDesktopGrid(context, projects);
        } else {
          return _buildMobileGrid(context, projects);
        }
      },
    );
  }

  Widget _buildDesktopGrid(BuildContext context, List<ProjectModel> projects) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: projects.map((project) {
        final index = projects.indexOf(project);
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: index < projects.length - 1 ? AppSizes.spacingLarge : 0,
            ),
            child: ProjectCard(
              project: project,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProjectDetailPage(project: project),
                  ),
                );
              },
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMobileGrid(BuildContext context, List<ProjectModel> projects) {
    return Column(
      children: projects.map((project) {
        final index = projects.indexOf(project);
        return Padding(
          padding: EdgeInsets.only(
            bottom: index < projects.length - 1 ? AppSizes.spacingLarge : 0,
          ),
          child: ProjectCard(
            project: project,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProjectDetailPage(project: project),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  List<ProjectModel> _getProjects() {
    return [
      // Project Redesign UI/UX
      ProjectModel(
        icon: Icons.design_services,
        title: 'Redesign Aplikasi Web Task Force',
        subtitle: 'UI/UX Case Study',
        description:
            'A redesign project of a web-based task management application to improve user experience and visual clarity.',
        color: AppColors.warning,
        technologies: ['Figma', 'UI/UX Design', 'Wireframing', 'Prototyping'],
        imageUrl: 'assets/images/projects/taskforce_thumbnail.png',
        liveUrl:
            'https://www.figma.com/proto/h60GzaiUHiPp5zAzrcgK6U/UI-DESIGN-KEL-4---Task-Force?node-id=486-1826&p=f&t=ClyCbYWZOllTlV64-1&scaling=scale-down&content-scaling=fixed&page-id=1%3A7&starting-point-node-id=486%3A1826',
        role: 'UI/UX Designer',
        duration: '2 weeks',
        tools: 'Figma',
        problemTitle: 'The Problem',
        problemDescription:
            'Pengguna mengalami kesulitan dalam melacak status tugas karena tata letak yang kurang jelas dan hierarki visual yang berantakan. Ini menyebabkan efisiensi kerja yang rendah.',
        goalTitle: 'The Goal',
        goalDescription:
            'Menciptakan antarmuka yang bersih dan intuitif yang meningkatkan produktivitas pengguna, menyederhanakan alur kerja manajemen tugas, dan memberikan pengalaman visual yang lebih baik.',
        designProcess: [
          {'title': 'Empathize & Define', 'step': 1},
          {'title': 'Ideate & Prototype', 'step': 2},
          {'title': 'User Testing', 'step': 3},
        ],
        previewImages: [
          {
            'title': 'Halaman Dashboard',
            'imagePath': 'assets/images/projects/taskforce_dashboard.png',
          },
          {
            'title': 'Tampilan Daftar Tugas',
            'imagePath': 'assets/images/projects/taskforce_list.png',
          },
          {
            'title': 'Modal Tugas Baru',
            'imagePath': 'assets/images/projects/taskforce_modal.png',
          },
        ],
      ),
      // Contoh Project Lama yang diupdate
      ProjectModel(
        icon: Icons.shopping_cart,
        title: 'E-Commerce Mobile App',
        subtitle: 'Mobile App Development',
        description:
            'A complete e-commerce solution built with Flutter featuring user authentication, product catalog, shopping cart, and payment integration.',
        color: AppColors.primary,
        technologies: ['Flutter', 'Firebase', 'Provider', 'REST API'],
        githubUrl: 'https://github.com/IrvanVansy/ecommerce-app',
        liveUrl: null,
      ),
      // Contoh Project Lama yang diupdate
      ProjectModel(
        icon: Icons.cloud,
        title: 'Weather Forecast App',
        subtitle: 'Mobile App Development',
        description:
            'A beautiful weather application with real-time data, 7-day forecast, and location-based weather updates using OpenWeather API.',
        color: AppColors.info,
        technologies: ['Flutter', 'OpenWeather API', 'Bloc', 'Location'],
        githubUrl: 'https://github.com/IrvanVansy/weather-app',
        liveUrl: null,
      ),
    ];
  }
}

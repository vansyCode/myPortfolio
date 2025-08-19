import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_constants.dart';
import '../models/project_model.dart';
import '../painters/grid_background_painter.dart';

class ProjectDetailPage extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailPage({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: AppBar(
        title: const Text(''), // Ganti title dengan widget kosong
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Padding(
              padding: const EdgeInsets.all(AppSizes.horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSizes.spacingExtraLarge),
                  _buildProjectSummaryCard(context),
                  const SizedBox(height: AppSizes.spacingExtraLarge),
                  _buildProblemSection(),
                  const SizedBox(height: AppSizes.spacingExtraLarge),
                  _buildGoalSection(),
                  const SizedBox(height: AppSizes.spacingExtraLarge),
                  _buildDesignProcessSection(),
                  const SizedBox(height: AppSizes.spacingExtraLarge),
                  _buildSolutionPreviewSection(context),
                  const SizedBox(height: AppSizes.spacingXXLarge),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: GridBackgroundPainter(
                gridSize: AppSizes.gridSize,
                lineColor: AppColors.gridColor.withOpacity(0.3),
                strokeWidth: 0.5,
              ),
            ),
          ),
          Center(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.spacingLarge),
                child: Column(
                  children: [
                    const SizedBox(height: AppSizes.spacingExtraLarge),
                    Text(
                      project.title,
                      style: TextStyle(
                        fontSize: AppFontSizes.titleLarge,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSizes.spacingMedium),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.horizontalPadding,
                        vertical: AppSizes.spacingSmall,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(
                          AppSizes.buttonRadius,
                        ),
                      ),
                      child: Text(
                        project.subtitle!,
                        style: TextStyle(
                          fontSize: AppFontSizes.body,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSizes.spacingExtraLarge),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectSummaryCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.projectSummaryTitle,
            style: TextStyle(
              fontSize: AppFontSizes.titleMedium,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSizes.spacingExtraLarge),
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > AppBreakpoints.mobile;
              if (isDesktop) {
                return Row(
                  children: [
                    Expanded(
                      child: _buildSummaryItem(
                        project.role!,
                        Icons.design_services,
                      ),
                    ),
                    const SizedBox(width: AppSizes.spacingLarge),
                    Expanded(
                      child: _buildSummaryItem(
                        project.duration!,
                        Icons.schedule,
                      ),
                    ),
                    const SizedBox(width: AppSizes.spacingLarge),
                    Expanded(
                      child: _buildSummaryItem(
                        project.tools!,
                        Icons.color_lens,
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildSummaryItem(project.role!, Icons.design_services),
                    const SizedBox(height: AppSizes.spacingLarge),
                    _buildSummaryItem(project.duration!, Icons.schedule),
                    const SizedBox(height: AppSizes.spacingLarge),
                    _buildSummaryItem(project.tools!, Icons.color_lens),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.spacingLarge),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.spacingSmall),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            ),
            child: Icon(icon, color: Colors.white, size: AppSizes.spacingLarge),
          ),
          const SizedBox(width: AppSizes.spacingMedium),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: AppFontSizes.bodyLarge,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProblemSection() {
    return _buildContentSection(
      project.problemTitle!,
      project.problemDescription!,
      AppColors.error.withOpacity(0.1),
      AppColors.error,
      Icons.error_outline,
    );
  }

  Widget _buildGoalSection() {
    return _buildContentSection(
      project.goalTitle!,
      project.goalDescription!,
      AppColors.primary.withOpacity(0.1),
      AppColors.primary,
      Icons.flag,
    );
  }

  Widget _buildContentSection(
    String title,
    String content,
    Color bgColor,
    Color iconColor,
    IconData icon,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.spacingMedium),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: AppSizes.spacingLarge,
                ),
              ),
              const SizedBox(width: AppSizes.spacingMedium),
              Text(
                title,
                style: TextStyle(
                  fontSize: AppFontSizes.titleMedium,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spacingLarge),
          Container(
            padding: const EdgeInsets.all(AppSizes.cardPadding),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
            ),
            child: Text(
              content,
              style: TextStyle(
                fontSize: AppFontSizes.bodyLarge,
                height: 1.6,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesignProcessSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.spacingMedium),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                ),
                child: const Icon(
                  Icons.psychology,
                  color: AppColors.primary,
                  size: AppSizes.spacingLarge,
                ),
              ),
              const SizedBox(width: AppSizes.spacingMedium),
              Text(
                AppStrings.designProcessTitle,
                style: TextStyle(
                  fontSize: AppFontSizes.titleMedium,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spacingExtraLarge),
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > AppBreakpoints.mobile;
              final steps = project.designProcess!
                  .map(
                    (step) =>
                        _buildProcessStep(step['title']!, step['step'] as int),
                  )
                  .toList();
              if (isDesktop) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: steps.map((step) => Expanded(child: step)).toList(),
                );
              } else {
                return Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // <-- Sudah benar
                  // Baris-baris ini menyebabkan masalah karena tidak menggunakan spasi
                  // children: [
                  //   steps[0],
                  //   steps[1],
                  //   steps[2],
                  // ],
                  // Ganti dengan kode di bawah ini:
                  children: [
                    _buildProcessStep(
                      project.designProcess![0]['title']!,
                      project.designProcess![0]['step'] as int,
                    ),
                    const SizedBox(height: AppSizes.spacingLarge),
                    _buildProcessStep(
                      project.designProcess![1]['title']!,
                      project.designProcess![1]['step'] as int,
                    ),
                    const SizedBox(height: AppSizes.spacingLarge),
                    _buildProcessStep(
                      project.designProcess![2]['title']!,
                      project.designProcess![2]['step'] as int,
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProcessStep(String title, int step) {
    return Container(
      width:
          double.infinity, // Memberikan lebar penuh agar Center dapat bekerja
      padding: const EdgeInsets.all(AppSizes.cardPadding),
      margin: const EdgeInsets.symmetric(vertical: AppSizes.spacingSmall),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.primary.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Container(
            width: AppSizes.spacingXXLarge,
            height: AppSizes.spacingXXLarge,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSizes.title,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          Text(
            title,
            style: TextStyle(
              fontSize: AppFontSizes.bodyLarge,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSolutionPreviewSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.spacingMedium),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                ),
                child: const Icon(
                  Icons.preview,
                  color: AppColors.primary,
                  size: AppSizes.spacingLarge,
                ),
              ),
              const SizedBox(width: AppSizes.spacingMedium),
              Text(
                AppStrings.solutionPreviewTitle,
                style: TextStyle(
                  fontSize: AppFontSizes.titleMedium,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spacingExtraLarge),
          _buildPreviewCards(context),
          const SizedBox(height: AppSizes.spacingExtraLarge),
          if (project.liveUrl != null)
            Center(
              child: ElevatedButton(
                onPressed: () => _launchURL(project.liveUrl!),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.spacingExtraLarge,
                    vertical: AppSizes.spacingMedium,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.open_in_new),
                    const SizedBox(width: AppSizes.spacingSmall),
                    Text(
                      AppStrings.viewPrototypeButton,
                      style: TextStyle(
                        fontSize: AppFontSizes.bodyLarge,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPreviewCards(BuildContext context) {
    final previewCards = project.previewImages!.asMap().entries.map((entry) {
      final index = entry.key;
      final preview = entry.value;
      return _buildPreviewCard(preview['title']!, preview['imagePath']!);
    }).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > AppBreakpoints.desktop;
        final isTablet = constraints.maxWidth > AppBreakpoints.mobile;

        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: previewCards
                .map((card) => Expanded(child: card))
                .toList(),
          );
        } else if (isTablet) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: previewCards[0]),
                  const SizedBox(width: AppSizes.spacingLarge),
                  Expanded(child: previewCards[1]),
                ],
              ),
              const SizedBox(height: AppSizes.spacingLarge),
              previewCards.length > 2
                  ? previewCards[2]
                  : const SizedBox.shrink(),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: previewCards.map((card) {
              final index = previewCards.indexOf(card);
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index < previewCards.length - 1
                      ? AppSizes.spacingLarge
                      : 0,
                ),
                child: card,
              );
            }).toList(),
          );
        }
      },
    );
  }

  Widget _buildPreviewCard(String title, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          const SizedBox(height: AppSizes.spacingMedium),
          Text(
            title,
            style: TextStyle(
              fontSize: AppFontSizes.bodyLarge,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSizes.spacingMedium),
        ],
      ),
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

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project_model.dart';
import '../utils/app_constants.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final VoidCallback? onTap; // Tambahkan parameter onTap

  const ProjectCard({Key? key, required this.project, this.onTap})
    : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppDurations.fast,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: AppCurves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: InkWell(
              onTap: widget.onTap, // Gunakan onTap di sini
              borderRadius: BorderRadius.circular(AppSizes.cardRadius),
              child: Container(
                padding: EdgeInsets.all(AppSizes.cardPadding),
                decoration: BoxDecoration(
                  color: AppColors.backgroundPrimary,
                  borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cardShadow,
                      blurRadius: _isHovered ? 15 : 10,
                      offset: Offset(0, _isHovered ? 8 : 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProjectIcon(),
                    SizedBox(height: AppSizes.spacingMedium),
                    _buildProjectTitle(),
                    SizedBox(height: AppSizes.spacingSmall),
                    _buildProjectDescription(),
                    SizedBox(height: AppSizes.spacingMedium),
                    _buildTechnologies(),
                    SizedBox(height: AppSizes.spacingMedium),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  Widget _buildProjectIcon() {
    return Container(
      padding: EdgeInsets.all(AppSizes.spacingMedium),
      decoration: BoxDecoration(
        color: widget.project.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
      ),
      child: Icon(widget.project.icon, size: 30, color: widget.project.color),
    );
  }

  Widget _buildProjectTitle() {
    return Text(
      widget.project.title,
      style: TextStyle(
        fontSize: AppFontSizes.title,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildProjectDescription() {
    return Text(
      widget.project.description,
      style: TextStyle(
        fontSize: AppFontSizes.body,
        color: AppColors.textSecondary,
        height: 1.5,
      ),
    );
  }

  Widget _buildTechnologies() {
    return Wrap(
      spacing: AppSizes.spacingXSmall,
      runSpacing: AppSizes.spacingXSmall,
      children: widget.project.technologies.map((tech) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.spacingSmall,
            vertical: AppSizes.spacingXSmall,
          ),
          decoration: BoxDecoration(
            color: widget.project.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          ),
          child: Text(
            tech,
            style: TextStyle(
              fontSize: AppFontSizes.caption,
              color: widget.project.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons() {
    if (widget.project.liveUrl != null || widget.project.githubUrl != null) {
      return Row(
        children: [
          if (widget.project.githubUrl != null)
            Expanded(
              child: _buildActionButton(
                'GitHub',
                Icons.code,
                () => _launchURL(widget.project.githubUrl!),
              ),
            ),
          if (widget.project.githubUrl != null &&
              widget.project.liveUrl != null)
            SizedBox(width: AppSizes.spacingSmall),
          if (widget.project.liveUrl != null)
            Expanded(
              child: _buildActionButton(
                'Live Demo',
                Icons.launch,
                () => _launchURL(widget.project.liveUrl!),
              ),
            ),
        ],
      );
    }
    return const SizedBox.shrink(); // Widget kosong jika tidak ada URL
  }

  Widget _buildActionButton(
    String text,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: AppFontSizes.body),
      label: Text(text),
      style: OutlinedButton.styleFrom(
        foregroundColor: widget.project.color,
        side: BorderSide(color: widget.project.color, width: 2),
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.spacingSmall,
          vertical: AppSizes.spacingSmall,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        ),
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

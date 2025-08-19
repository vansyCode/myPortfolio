import 'package:flutter/material.dart';
import '../utils/app_constants.dart';

class ContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String contact;
  final VoidCallback onTap;

  const ContactCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.contact,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard>
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
              onTap: widget.onTap,
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
                  children: [
                    _buildIcon(),
                    SizedBox(height: AppSizes.spacingMedium),
                    _buildTitle(),
                    SizedBox(height: AppSizes.spacingXSmall),
                    _buildContact(),
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

  Widget _buildIcon() {
    return Container(
      padding: EdgeInsets.all(AppSizes.spacingMedium),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(widget.icon, size: 30, color: AppColors.primary),
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.title,
      style: TextStyle(
        fontSize: AppFontSizes.subtitle,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildContact() {
    return Text(
      widget.contact,
      style: TextStyle(
        fontSize: AppFontSizes.body,
        color: AppColors.textSecondary,
      ),
      textAlign: TextAlign.center,
    );
  }
}

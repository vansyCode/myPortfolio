// OPTIMIZED HOME SECTION
import 'package:flutter/material.dart';
import '../utils/app_constants.dart';
import '../painters/grid_background_painter.dart';

class OptimizedHomeSection extends StatelessWidget {
  final VoidCallback onViewPortfolio;
  final VoidCallback onContactMe;

  const OptimizedHomeSection({
    Key? key,
    required this.onViewPortfolio,
    required this.onContactMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.homeSectionHeight,
      child: Stack(
        children: [
          // OPTIMIZATION: Use RepaintBoundary untuk isolate painting
          const RepaintBoundary(child: _GridBackground()),

          // OPTIMIZATION: Center content dengan minimal rebuilds
          const _HomeContent(),

          // OPTIMIZATION: Positioned buttons untuk menghindari layout shifts
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: _ActionButtons(
              onViewPortfolio: onViewPortfolio,
              onContactMe: onContactMe,
            ),
          ),
        ],
      ),
    );
  }
}

// OPTIMIZATION: Separate grid background widget
class _GridBackground extends StatelessWidget {
  const _GridBackground();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(
        painter: GridBackgroundPainter(
          gridSize: AppSizes.gridSize,
          lineColor: AppColors.gridColor,
        ),
        // OPTIMIZATION: willChange hint untuk GPU acceleration
        willChange: false,
      ),
    );
  }
}

// OPTIMIZATION: Separate content widget dengan const constructor
class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // OPTIMIZATION: Use const untuk static widgets
          const _ProfileImage(),
          const SizedBox(height: 30),
          const _TitleSection(),
        ],
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        width: AppSizes.profileImageLarge,
        height: AppSizes.profileImageLarge,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          image: const DecorationImage(
            image: AssetImage(AppAssets.profileImage),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > AppBreakpoints.tablet;

    return Column(
      children: [
        Text(
          AppStrings.homeTitle,
          style: TextStyle(
            fontSize: isDesktop
                ? AppFontSizes.titleLarge
                : AppFontSizes.titleMedium,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15),
        const Text(
          AppStrings.homeSubtitle,
          style: TextStyle(
            fontSize: AppFontSizes.bodyLarge,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// OPTIMIZATION: Separate action buttons dengan minimal rebuilds
class _ActionButtons extends StatelessWidget {
  final VoidCallback onViewPortfolio;
  final VoidCallback onContactMe;

  const _ActionButtons({
    required this.onViewPortfolio,
    required this.onContactMe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PrimaryButton(onPressed: onViewPortfolio),
          const SizedBox(width: 20),
          _SecondaryButton(onPressed: onContactMe),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _PrimaryButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 0,
      ),
      child: const Text(
        AppStrings.viewPortfolioButton,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SecondaryButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      child: const Text(
        AppStrings.contactMeButton,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// OPTIMIZATION: Lazy loading untuk portfolio section
class OptimizedPortfolioSection extends StatefulWidget {
  const OptimizedPortfolioSection({Key? key}) : super(key: key);

  @override
  State<OptimizedPortfolioSection> createState() =>
      _OptimizedPortfolioSectionState();
}

class _OptimizedPortfolioSectionState extends State<OptimizedPortfolioSection>
    with AutomaticKeepAliveClientMixin {
  // OPTIMIZATION: Keep state alive untuk menghindari rebuild
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: AppColors.backgroundSecondary,
      child: Column(
        children: [
          const _PortfolioHeader(),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              // OPTIMIZATION: Cache responsive breakpoint
              final isDesktop = constraints.maxWidth > AppBreakpoints.tablet;

              return RepaintBoundary(
                child: isDesktop
                    ? const _DesktopProjectGrid()
                    : const _MobileProjectGrid(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PortfolioHeader extends StatelessWidget {
  const _PortfolioHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          AppStrings.portfolioTitle,
          style: TextStyle(
            fontSize: AppFontSizes.sectionTitle,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 15),
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
}

// OPTIMIZATION: Separate grid layouts
class _DesktopProjectGrid extends StatelessWidget {
  const _DesktopProjectGrid();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _ProjectCard1()),
        SizedBox(width: 30),
        Expanded(child: _ProjectCard2()),
        SizedBox(width: 30),
        Expanded(child: _ProjectCard3()),
      ],
    );
  }
}

class _MobileProjectGrid extends StatelessWidget {
  const _MobileProjectGrid();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _ProjectCard1(),
        SizedBox(height: 30),
        _ProjectCard2(),
        SizedBox(height: 30),
        _ProjectCard3(),
      ],
    );
  }
}

// OPTIMIZATION: Pre-built project cards dengan const
class _ProjectCard1 extends StatelessWidget {
  const _ProjectCard1();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProjectIcon(Icons.shopping_cart, AppColors.primary),
          SizedBox(height: 20),
          _ProjectTitle('E-Commerce Mobile App'),
          SizedBox(height: 10),
          _ProjectDescription(
            'A complete e-commerce solution built with Flutter featuring user authentication, product catalog, shopping cart, and payment integration.',
          ),
        ],
      ),
    );
  }
}

class _ProjectCard2 extends StatelessWidget {
  const _ProjectCard2();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProjectIcon(Icons.cloud, Color(0xFF64B5F6)),
          SizedBox(height: 20),
          _ProjectTitle('Weather Forecast App'),
          SizedBox(height: 10),
          _ProjectDescription(
            'A beautiful weather application with real-time data, 7-day forecast, and location-based weather updates using OpenWeather API.',
          ),
        ],
      ),
    );
  }
}

class _ProjectCard3 extends StatelessWidget {
  const _ProjectCard3();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProjectIcon(Icons.task_alt, Color(0xFF9C27B0)),
          SizedBox(height: 20),
          _ProjectTitle('Task Management App'),
          SizedBox(height: 10),
          _ProjectDescription(
            'A productivity app for managing daily tasks with features like categories, reminders, and progress tracking.',
          ),
        ],
      ),
    );
  }
}

class _ProjectIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _ProjectIcon(this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 30, color: color),
    );
  }
}

class _ProjectTitle extends StatelessWidget {
  final String title;

  const _ProjectTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _ProjectDescription extends StatelessWidget {
  final String description;

  const _ProjectDescription(this.description);

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: const TextStyle(
        fontSize: 14,
        color: AppColors.textSecondary,
        height: 1.5,
      ),
    );
  }
}

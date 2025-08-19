import 'package:flutter/material.dart';
import '../utils/app_constants.dart';

class WelcomeScreen extends StatelessWidget {
  final AnimationController loadingController;

  const WelcomeScreen({Key? key, required this.loadingController})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryLight],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLogo(), // Ini yang akan kita ubah
          SizedBox(height: AppSizes.spacingLarge),
          _buildTitle(),
          SizedBox(height: AppSizes.spacingSmall),
          _buildSubtitle(),
          SizedBox(height: AppSizes.spacingXXLarge),
          _buildLoadingIndicator(),
          SizedBox(height: AppSizes.spacingMedium),
          _buildLoadingText(),
        ],
      ),
    );
  }

  // Metode ini akan diubah untuk menampilkan logo dari assets
  Widget _buildLogo() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.spacingMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      // PERUBAHAN DI SINI: Mengganti Icon dengan Image.asset
      child: Padding(
        // Tambahkan Padding agar logo tidak terlalu mepet
        padding: const EdgeInsets.all(16.0), // Sesuaikan padding jika perlu
        child: Image.asset(
          AppAssets.logo, // Menggunakan path logo dari AppAssets
          fit: BoxFit.contain, // Memastikan logo menyesuaikan ukuran container
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      AppStrings.welcomeTitle,
      style: TextStyle(
        color: Colors.white,
        fontSize: AppFontSizes.titleMedium,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      AppStrings.welcomeSubtitle,
      style: TextStyle(color: Colors.white70, fontSize: AppFontSizes.subtitle),
    );
  }

  Widget _buildLoadingIndicator() {
    return RotationTransition(
      turns: loadingController,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        ),
        child: Image.asset(AppAssets.logo, fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildLoadingText() {
    return Text(
      'Loading...',
      style: TextStyle(color: Colors.white70, fontSize: AppFontSizes.body),
    );
  }
}

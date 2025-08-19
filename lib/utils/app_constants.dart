import 'package:flutter/material.dart';

// Colors
class AppColors {
  static const Color primary = Color(0xFF00BFA5);
  static const Color primaryDark = Color(0xFF009E88);
  static const Color primaryLight = Color(0xFF00695C);

  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textTertiary = Color(0xFF999999);

  static const Color backgroundPrimary = Colors.white;
  static const Color backgroundSecondary = Color(0xFFF5F5F5);

  static const Color gridColor = Color(0xFFE0E0E0);
  static const Color cardShadow = Color(0x1A000000);

  static const Color footerBackground = Color(0xFF1E293B);
  static const Color footerTextPrimary = Colors.white;
  static const Color footerTextSecondary = Color(0xFFB3B3B3);
  static const Color footerTextTertiary = Color(0xFF888888);
  static const Color footerDivider = Color(0x40FFFFFF);

  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53E3E);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
}

// Font Sizes
class AppFontSizes {
  static const double caption = 12.0;
  static const double body = 14.0;
  static const double bodyLarge = 16.0;
  static const double button = 14.0;
  static const double subtitle = 18.0;
  static const double title = 20.0;
  static const double titleMedium = 24.0;
  static const double titleLarge = 32.0;
  static const double sectionTitle = 36.0;
  static const double heroTitle = 48.0;
}

// Sizes and Spacing
class AppSizes {
  // Spacing
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingExtraLarge = 32.0;
  static const double spacingXXLarge = 48.0;

  // Padding
  static const double horizontalPadding = 20.0;
  static const double verticalPadding = 16.0;
  static const double sectionVerticalPadding = 80.0;
  static const double cardPadding = 24.0;

  // Border Radius
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusExtraLarge = 16.0;
  static const double buttonRadius = 25.0;
  static const double cardRadius = 15.0;

  // Button
  static const double buttonHorizontalPadding = 30.0;
  static const double buttonVerticalPadding = 15.0;
  static const double buttonHeight = 50.0;

  // Profile Images
  static const double profileImageSmall = 80.0;
  static const double profileImageMedium = 120.0;
  static const double profileImageLarge = 140.0;

  // Sections
  static const double homeSectionHeight = 500.0;
  static const double headerHeight = 80.0;

  // Grid
  static const double gridSize = 32.0;

  // Form
  static const double formMaxWidth = 600.0;
  static const double inputHeight = 56.0;
}

// Breakpoints
class AppBreakpoints {
  static const double mobile = 480.0;
  static const double tablet = 768.0;
  static const double desktop = 1024.0;
  static const double largeDesktop = 1440.0;
}

// Strings
class AppStrings {
  // Personal Info
  static const String fullName = 'M. Irvan Sinado';
  static const String firstName = 'Irvan';
  static const String lastName = 'Sinado';
  static const String profession = 'Flutter Developer';
  static const String location = 'Bandar Lampung, Indonesia';
  static const String education = 'Informatics Engineering Student';
  static const String university = 'University of Lampung';
  static const String email = 'irvansinado@gmail.com';
  static const String whatsapp = '+62 895 1100 6470 6';

  //project detail page
  static const String projectSummaryTitle = 'Project Summary';
  static const String designProcessTitle = 'Design Process';
  static const String solutionPreviewTitle = 'Solution Preview';
  static const String viewPrototypeButton = 'View Prototype on Figma';

  // Social Media URLs
  static const String facebookUrl =
      'https://web.facebook.com/dedeng.dedeng.90260403';
  static const String linkedinUrl = 'https://www.linkedin.com/in/irvan-sinado/';
  static const String githubUrl = 'https://github.com/IrvanVansy';
  static const String instagramUrl = 'https://instagram.com/irvansinado';

  // App Content
  static const String appTitle = 'M. Irvan Sinado - Portfolio';
  static const String welcomeTitle = 'M. Irvan Sinado';
  static const String welcomeSubtitle = 'Flutter Developer';

  // Home Section
  static const String homeTitle = 'Flutter Developer';
  static const String homeSubtitle =
      'I build beautiful, responsive mobile and web apps using Flutter.';
  static const String viewPortfolioButton = 'View Portfolio';
  static const String contactMeButton = 'Contact Me';

  // About Section
  static const String aboutTitle = 'About';
  static const String aboutDescription =
      'A passionate Flutter developer with a keen interest in building innovative and user-friendly applications.';

  // Portfolio Section
  static const String portfolioTitle = 'Portfolio';
  static const String portfolioSubtitle =
      'Here are some of my recent projects showcasing my skills in Flutter development.';

  // Contact Section
  static const String contactTitle = 'Contact';
  static const String contactSubtitle =
      'Let\'s work together! Feel free to reach out for any opportunities or collaborations.';
  static const String getInTouchTitle = 'Get In Touch';

  // Form
  static const String nameHint = 'Your Name';
  static const String emailHint = 'Your Email';
  static const String messageHint = 'Your Message';
  static const String sendMessageButton = 'Send Message';

  // Validation Messages
  static const String nameRequired = 'Name is required';
  static const String emailRequired = 'Email is required';
  static const String emailInvalid = 'Enter a valid email';
  static const String messageRequired = 'Message is required';

  // Success/Error Messages
  static const String messageSentSuccess = 'Message sent successfully!';
  static const String messageError = 'Please fill all fields correctly.';

  // Footer
  static const String footerTagline =
      'Flutter Developer • Building Beautiful Digital Experiences';
  static const String copyright =
      '© ${2025} M. Irvan Sinado. All rights reserved.\nBuilt with Flutter 💙';
}

// Assets
class AppAssets {
  static const String logo = 'assets/images/LogoVansyCoding.png';
  static const String profileImage = 'assets/images/pasFoto.jpg';

  // Project Images (if you have them)
  static const String ecommerceProject = 'assets/images/projects/ecommerce.png';
  static const String weatherProject = 'assets/images/projects/weather.png';
  static const String taskProject = 'assets/images/projects/task.png';
}

// Animation Durations
class AppDurations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration extraSlow = Duration(milliseconds: 800);

  static const Duration welcomeScreen = Duration(seconds: 3);
  static const Duration loadingAnimation = Duration(seconds: 2);
  static const Duration scrollAnimation = Duration(milliseconds: 800);
}

// Curves
class AppCurves {
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve easeInOutCubic = Curves.easeInOutCubic;
  static const Curve bounceIn = Curves.bounceIn;
  static const Curve elasticOut = Curves.elasticOut;
}

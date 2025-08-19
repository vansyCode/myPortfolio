import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Import file-file yang sudah Anda pisahkan
import 'painters/grid_background_painter.dart';
import 'utils/app_constants.dart';
import 'screens/welcome_screen.dart';
import 'widgets/custom_app_bar.dart';
import 'sections/home_section.dart';
import 'sections/about_section.dart';
import 'sections/portfolio_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle, // Menggunakan konstanta dari AppStrings
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily:
            'Inter', // Tetap menggunakan Inter atau pindahkan ke AppConstants jika ingin custom
        scaffoldBackgroundColor: AppColors.backgroundPrimary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PortfolioWebsite(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PortfolioWebsite extends StatefulWidget {
  @override
  _PortfolioWebsiteState createState() => _PortfolioWebsiteState();
}

class _PortfolioWebsiteState extends State<PortfolioWebsite>
    with TickerProviderStateMixin {
  bool showWelcome = true;
  late AnimationController _loadingController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final ScrollController _scrollController = ScrollController();
  // GlobalKey untuk setiap section agar bisa discroll ke sana
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  // State untuk melacak section yang sedang aktif (untuk highlight di AppBar)
  String _currentSection = 'Home';
  String? _hoveredNav; // Untuk efek hover di navigasi

  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(
      duration: AppDurations.loadingAnimation,
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: AppDurations.extraSlow,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: AppCurves.easeInOut),
    );

    _loadingController.repeat();

    // Sembunyikan halaman selamat datang setelah durasi tertentu
    Future.delayed(AppDurations.welcomeScreen, () {
      if (mounted) {
        setState(() {
          showWelcome = false;
        });
        _fadeController.forward();
      }
    });

    // Tambahkan listener untuk mendeteksi perubahan scroll dan update section aktif
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _loadingController.dispose();
    _fadeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Fungsi untuk melakukan scroll ke section tertentu
  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: AppDurations.scrollAnimation,
        curve: AppCurves.easeInOutCubic,
        alignment: 0.0, // Scroll ke bagian paling atas dari widget
      );
      // Langsung update _currentSection setelah klik untuk feedback instan
      setState(() {
        if (key == _homeKey) {
          _currentSection = 'Home';
        } else if (key == _aboutKey) {
          _currentSection = 'About';
        } else if (key == _portfolioKey) {
          _currentSection = 'Portfolio';
        } else if (key == _contactKey) {
          _currentSection = 'Contact';
        }
      });
    }
  }

  // Logika untuk mendeteksi section yang sedang aktif saat scroll
  void _onScroll() {
    String? newSection;
    final double scrollOffset = _scrollController.offset;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Definisikan semua section dengan GlobalKey mereka
    Map<String, GlobalKey> sections = {
      'Home': _homeKey,
      'About': _aboutKey,
      'Portfolio': _portfolioKey,
      'Contact': _contactKey,
    };

    // Urutkan section berdasarkan posisi dari atas (Home paling atas)
    // Ini penting agar deteksi section yang aktif lebih akurat saat scrolling
    final sortedSections = sections.entries.toList()
      ..sort((a, b) {
        final RenderBox? renderBoxA =
            a.value.currentContext?.findRenderObject() as RenderBox?;
        final RenderBox? renderBoxB =
            b.value.currentContext?.findRenderObject() as RenderBox?;

        if (renderBoxA == null || renderBoxB == null) return 0;

        final double positionA = renderBoxA.localToGlobal(Offset.zero).dy;
        final double positionB = renderBoxB.localToGlobal(Offset.zero).dy;

        return positionA.compareTo(positionB);
      });

    // Iterasi dari section yang paling atas ke bawah
    for (var entry in sortedSections) {
      final String name = entry.key;
      final GlobalKey key = entry.value;
      final RenderBox? renderBox =
          key.currentContext?.findRenderObject() as RenderBox?;

      if (renderBox != null) {
        // Dapatkan posisi relatif section terhadap viewport
        final Offset sectionOffset = renderBox.localToGlobal(Offset.zero);
        final double sectionTop = sectionOffset.dy;
        final double sectionBottom = sectionTop + renderBox.size.height;

        // Tentukan ambang batas visibilitas. Jika bagian atas section sudah melewati
        // 1/3 bagian atas layar, atau jika section tersebut menempati sebagian besar layar.
        // Anda bisa menyesuaikan threshold ini.
        const double visibilityThreshold = 0.3; // 30% dari tinggi layar
        if (sectionTop < screenHeight * (1 - visibilityThreshold) &&
            sectionBottom > screenHeight * visibilityThreshold) {
          newSection = name;
          // Begitu kita menemukan section yang dominan, kita bisa berhenti
          // karena kita mengasumsikan hanya satu section yang aktif pada satu waktu.
          break;
        }
      }
    }

    // Jika tidak ada section yang memenuhi kriteria dominan,
    // dan kita sudah scroll ke paling atas, set ke Home.
    if (newSection == null && scrollOffset <= 0) {
      newSection = 'Home';
    }

    // Hanya update state jika section aktif berubah
    if (newSection != null && newSection != _currentSection) {
      setState(() {
        _currentSection = newSection!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Peta GlobalKey untuk diteruskan ke CustomAppBar
    final Map<String, GlobalKey> sectionKeys = {
      'Home': _homeKey,
      'About': _aboutKey,
      'Portfolio': _portfolioKey,
      'Contact': _contactKey,
    };

    return Scaffold(
      body: SafeArea(
        child: showWelcome
            ? WelcomeScreen(loadingController: _loadingController)
            : FadeTransition(
                // Menggunakan FadeTransition untuk transisi setelah welcome screen
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    CustomAppBar(
                      currentSection: _currentSection,
                      hoveredNav: _hoveredNav,
                      onNavHover: (title) {
                        setState(() {
                          _hoveredNav = title;
                        });
                      },
                      onNavPressed: (title) {
                        // Temukan GlobalKey yang sesuai dan scroll ke sana
                        final key = sectionKeys[title];
                        if (key != null) {
                          _scrollToSection(key);
                        }
                      },
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            HomeSection(
                              key: _homeKey,
                              onViewPortfolio: () =>
                                  _scrollToSection(_portfolioKey),
                              onContactMe: () => _scrollToSection(_contactKey),
                            ),
                            AboutSection(key: _aboutKey),
                            PortfolioSection(key: _portfolioKey),
                            ContactSection(key: _contactKey),
                            FooterSection(
                              onHomePressed: () => _scrollToSection(_homeKey),
                              onAboutPressed: () => _scrollToSection(_aboutKey),
                              onPortfolioPressed: () =>
                                  _scrollToSection(_portfolioKey),
                              onContactPressed: () =>
                                  _scrollToSection(_contactKey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

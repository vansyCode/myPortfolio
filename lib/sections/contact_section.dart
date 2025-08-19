import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_constants.dart';
import '../widgets/contact_card.dart';
import '../widgets/contact_form.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.sectionVerticalPadding,
        horizontal: AppSizes.horizontalPadding,
      ),
      child: Column(
        children: [
          _buildSectionHeader(),
          SizedBox(height: AppSizes.spacingExtraLarge),
          _buildContactContent(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      children: [
        Text(
          AppStrings.contactTitle,
          style: TextStyle(
            fontSize: AppFontSizes.sectionTitle,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: AppSizes.spacingMedium),
        Text(
          AppStrings.contactSubtitle,
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

  Widget _buildContactContent(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > AppBreakpoints.tablet;

        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildContactCards()),
              SizedBox(width: AppSizes.spacingExtraLarge),
              Expanded(child: ContactForm()),
            ],
          );
        } else {
          return Column(
            children: [
              _buildContactCards(),
              SizedBox(height: AppSizes.spacingExtraLarge),
              ContactForm(),
            ],
          );
        }
      },
    );
  }

  Widget _buildContactCards() {
    return Column(
      children: [
        ContactCard(
          icon: Icons.email,
          title: 'Email',
          contact: AppStrings.email,
          onTap: () => _launchEmail(AppStrings.email),
        ),
        SizedBox(height: AppSizes.spacingLarge),
        ContactCard(
          icon: Icons.phone,
          title: 'WhatsApp',
          contact: AppStrings.whatsapp,
          onTap: () => _launchWhatsApp(AppStrings.whatsapp),
        ),
        SizedBox(height: AppSizes.spacingLarge),
        ContactCard(
          icon: Icons.location_on,
          title: 'Location',
          contact: AppStrings.location,
          onTap: () => _launchMaps(AppStrings.location),
        ),
      ],
    );
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Hello from Portfolio&body=Hi Irvan,',
    );

    try {
      if (!await launchUrl(emailUri)) {
        throw Exception('Could not launch email');
      }
    } catch (e) {
      debugPrint('Error launching email: $e');
    }
  }

  Future<void> _launchWhatsApp(String phoneNumber) async {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    final Uri whatsappUri = Uri.parse(
      'https://wa.me/$cleanNumber?text=Hello Irvan, I found your portfolio and would like to connect!',
    );

    try {
      if (!await launchUrl(whatsappUri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch WhatsApp');
      }
    } catch (e) {
      debugPrint('Error launching WhatsApp: $e');
    }
  }

  Future<void> _launchMaps(String location) async {
    final Uri mapsUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(location)}',
    );

    try {
      if (!await launchUrl(mapsUri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch Maps');
      }
    } catch (e) {
      debugPrint('Error launching Maps: $e');
    }
  }
}

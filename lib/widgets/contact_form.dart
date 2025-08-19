import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import package http
import 'dart:convert'; // Untuk mengkonversi JSON
import '../utils/app_constants.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: AppSizes.formMaxWidth),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFormTitle(),
              SizedBox(height: AppSizes.spacingLarge),
              _buildNameField(),
              SizedBox(height: AppSizes.spacingMedium),
              _buildEmailField(),
              SizedBox(height: AppSizes.spacingMedium),
              _buildMessageField(),
              SizedBox(height: AppSizes.spacingLarge),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormTitle() {
    return Text(
      AppStrings.getInTouchTitle,
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: AppFontSizes.titleMedium,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: _buildInputDecoration(AppStrings.nameHint, Icons.person),
      validator: (value) => value == null || value.trim().isEmpty
          ? AppStrings.nameRequired
          : null,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: _buildInputDecoration(AppStrings.emailHint, Icons.email),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return AppStrings.emailRequired;
        }
        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
        if (!emailRegex.hasMatch(value.trim())) {
          return AppStrings.emailInvalid;
        }
        return null;
      },
    );
  }

  Widget _buildMessageField() {
    return TextFormField(
      controller: _messageController,
      decoration: _buildInputDecoration(AppStrings.messageHint, Icons.message),
      maxLines: 5,
      textInputAction: TextInputAction.done,
      validator: (value) => value == null || value.trim().isEmpty
          ? AppStrings.messageRequired
          : null,
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _submitForm,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.buttonHorizontalPadding,
          vertical: AppSizes.buttonVerticalPadding,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        ),
        elevation: 0,
      ),
      child: _isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              AppStrings.sendMessageButton,
              style: TextStyle(
                fontSize: AppFontSizes.button,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }

  InputDecoration _buildInputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.primary),
      filled: true,
      fillColor: AppColors.backgroundPrimary,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        borderSide: BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSizes.spacingMedium,
        vertical: AppSizes.spacingMedium,
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      _showMessage(AppStrings.messageError, AppColors.error);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final name = _nameController.text;
      final email = _emailController.text;
      final message = _messageController.text;

      // Panggil fungsi untuk mengirim data ke backend
      await _sendDataToBackend(name, email, message);

      _clearForm();
    } catch (e) {
      _showMessage(
        'Terjadi kesalahan saat mengirim pesan. Silakan coba lagi.',
        AppColors.error,
      );
      debugPrint('Error submit form: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Fungsi baru untuk mengirim data ke backend Python
  Future<void> _sendDataToBackend(
    String name,
    String email,
    String message,
  ) async {
    // Ganti URL ini dengan alamat IP lokal komputer Anda jika Anda menjalankan
    // aplikasi Flutter di perangkat fisik dan backend di komputer yang sama.
    // Jika di emulator, '10.0.2.2' adalah alias untuk localhost komputer Anda.
    // Jika di web, gunakan 'http://localhost:5000' atau domain backend Anda.
    final String backendUrl =
        (Theme.of(context).platform == TargetPlatform.android ||
            Theme.of(context).platform == TargetPlatform.iOS)
        ? 'http://192.168.112.38:5000/send_email' // Untuk emulator Android/iOS
        : 'http://localhost:5000/send_email'; // Untuk web atau desktop

    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        _showMessage(AppStrings.messageSentSuccess, AppColors.success);
      } else {
        // Jika backend mengembalikan error
        final responseBody = jsonDecode(response.body);
        _showMessage(
          'Gagal mengirim pesan: ${responseBody['message'] ?? 'Unknown error'}',
          AppColors.error,
        );
        debugPrint('Backend Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Tangani error jaringan atau lainnya
      _showMessage(
        'Tidak dapat terhubung ke server. Pastikan backend berjalan.',
        AppColors.error,
      );
      debugPrint('Network/Server Error: $e');
    }
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        ),
      ),
    );
  }
}

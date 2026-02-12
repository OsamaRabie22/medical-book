import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/utils/validators.dart';
import '../../../models/patient_model.dart';
import '../../../widgets/custom_input_field.dart';
import '../home/home_page.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  void _login() {
    setState(() {
      _emailError = Validators.validateEmail(_emailController.text);
      _passwordError = Validators.validatePassword(_passwordController.text);
    });

    if (_emailError == null && _passwordError == null) {
      final patient = Patient(
        patientName: '',
        patientAge: 0,
        patientGender: '',
        patientCity: '',
        patientEmail: _emailController.text,
        patientPassword: _passwordController.text,
        patientMarried: false,
        patientPhone: '',
        patientImage: null,
      );

      // TODO: Send login request with patient.toLoginJson()
      print('Login Data: ${patient.toLoginJson()}');

      Get.offAll(const HomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 28 * scale,
          vertical: 40 * scale,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            RichText(
              text: TextSpan(
                style: AppTextStyles.headlineLarge.copyWith(
                  fontSize: 32 * scale,
                ),
                children: [
                  const TextSpan(
                    text: "Medical ",
                    style: TextStyle(color: AppColors.black),
                  ),
                  TextSpan(
                    text: "Book",
                    style: TextStyle(color: AppColors.primary),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20 * scale),

            // Image
            Container(
              height: 220 * scale,
              width: 220 * scale,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25 * scale),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25 * scale),
                child: Image.asset(
                  'assets/ChatGPT Image 3 نوفمبر 2025، 05_11_39 ص.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 30 * scale),

            // Welcome
            Text(
              "Welcome Back 👋",
              style: AppTextStyles.headlineMedium.copyWith(
                fontSize: 26 * scale,
                color: AppColors.primaryDark,
              ),
            ),
            SizedBox(height: 8 * scale),
            Text(
              "Stay connected to your health records\nlogin to continue",
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 16 * scale,
                color: AppColors.greyDark,
                height: 1.4,
              ),
            ),

            SizedBox(height: 40 * scale),

            // Email Field
            _buildInputField(
              controller: _emailController,
              hint: "Email Address",
              icon: Icons.email_outlined,
              error: _emailError,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {
                  _emailError = Validators.validateEmail(value);
                });
              },
              scale: scale,
            ),

            SizedBox(height: 16 * scale),

            // Password Field
            _buildInputField(
              controller: _passwordController,
              hint: "Password",
              icon: Icons.lock_outline,
              isPassword: true,
              error: _passwordError,
              onChanged: (value) {
                setState(() {
                  _passwordError = Validators.validatePassword(value);
                });
              },
              scale: scale,
            ),

            SizedBox(height: 40 * scale),

            // Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(vertical: 16 * scale),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14 * scale),
                  ),
                  elevation: 4,
                ),
                child: Text(
                  "Login",
                  style: AppTextStyles.buttonMedium.copyWith(
                    fontSize: 18 * scale,
                  ),
                ),
              ),
            ),

            SizedBox(height: 35 * scale),

            // Sign Up Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.greyDark,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(const SignupPage());
                  },
                  child: Text(
                    "Sign Up",
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    String? error,
    TextInputType keyboardType = TextInputType.text,
    required double scale,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      CustomInputField(
      controller: controller,
      hint: hint,
      icon: icon,
      isPassword: isPassword,
      hasError: error != null,
      keyboardType: keyboardType,
      onChanged: onChanged,
      scale: scale,
      ),
        if (error != null)
          Padding(
            padding: EdgeInsets.only(left: 16 * scale, top: 4 * scale),
            child: Text(
              error,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.error,
                fontSize: 11 * scale,
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
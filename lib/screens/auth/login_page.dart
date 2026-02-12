import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_book/screens/auth/signup_page.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../widgets/custom_input_field.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    // TODO: Add actual authentication logic
    Get.offAll(const HomePage()); // ✅ GetX للتنقل
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
            // ✅ اللوجو
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

            // ✅ الصورة
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

            // ✅ الترحيب
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

            // ✅ حقول الإدخال
            CustomInputField(
              controller: _usernameController,
              hint: "Username",
              icon: Icons.person_outline,
              scale: scale,
            ),
            SizedBox(height: 16 * scale),
            CustomInputField(
              controller: _passwordController,
              hint: "Password",
              icon: Icons.lock_outline,
              isPassword: true,
              scale: scale,
            ),

            SizedBox(height: 40 * scale),

            // ✅ زر تسجيل الدخول
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

            // ✅ إنشاء حساب جديد
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
                    Get.to(const SignupPage()); // ✅ GetX للتنقل
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

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

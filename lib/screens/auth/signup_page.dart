import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/utils/validators.dart';
import '../../../widgets/custom_input_field.dart';
import 'medical_info_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedGender;
  DateTime? _selectedDate;

  // متغيرات لتتبع الأخطاء
  bool _nameError = false;
  bool _emailError = false;
  bool _phoneError = false;
  bool _passwordError = false;
  bool _confirmPasswordError = false;
  bool _genderError = false;
  bool _birthDateError = false;

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);

    Future<void> _selectDate() async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (picked != null && picked != _selectedDate) {
        setState(() {
          _selectedDate = picked;
          _birthDateError = false;
        });
      }
    }

    String _calculateAge() {
      if (_selectedDate == null) return '';
      return Validators.calculateAge(_selectedDate!).toString();
    }

    void _validateAllFields() {
      setState(() {
        _nameError = _nameController.text.isEmpty;
        _emailError = !Validators.isValidEmail(_emailController.text);
        _phoneError = !Validators.isValidPhone(_phoneController.text);
        _passwordError = !Validators.isValidPassword(_passwordController.text);
        _confirmPasswordError =
            _confirmPasswordController.text != _passwordController.text;
        _genderError = _selectedGender == null;
        _birthDateError = _selectedDate == null;
      });
    }

    bool _canProceed() {
      return !_nameError &&
          !_emailError &&
          !_phoneError &&
          !_passwordError &&
          !_confirmPasswordError &&
          !_genderError &&
          !_birthDateError;
    }

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

            // ✅ صورة رمزية
            Container(
              height: 120 * scale,
              width: 120 * scale,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person_add_alt_1,
                size: 40 * scale,
                color: AppColors.primary,
              ),
            ),

            SizedBox(height: 20 * scale),

            Text(
              "Create Patient Account",
              style: AppTextStyles.headlineMedium.copyWith(
                fontSize: 22 * scale,
                color: AppColors.primaryDark,
              ),
            ),
            SizedBox(height: 8 * scale),
            Text(
              "Step 1: Basic Information",
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 30 * scale),

            // ✅ الاسم
            _buildInputField(
              controller: _nameController,
              hint: "Full Name *",
              icon: Icons.person_outline,
              error: _nameError,
              errorText: "Please enter your name",
              scale: scale,
            ),

            SizedBox(height: 16 * scale),

            // ✅ الإيميل
            _buildInputField(
              controller: _emailController,
              hint: "Email Address *",
              icon: Icons.email_outlined,
              error: _emailError,
              errorText: "Please enter a valid email",
              scale: scale,
            ),

            SizedBox(height: 16 * scale),

            // ✅ رقم التليفون
            _buildInputField(
              controller: _phoneController,
              hint: "Phone Number *",
              icon: Icons.phone_outlined,
              error: _phoneError,
              errorText: "Please enter a valid phone number",
              keyboardType: TextInputType.phone,
              scale: scale,
            ),

            SizedBox(height: 16 * scale),

            // ✅ تاريخ الميلاد
            _buildDateField(
              selectedDate: _selectedDate,
              onTap: _selectDate,
              error: _birthDateError,
              calculateAge: _calculateAge,
              scale: scale,
            ),

            SizedBox(height: 16 * scale),

            // ✅ النوع
            _buildGenderField(
              selectedGender: _selectedGender,
              error: _genderError,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                  _genderError = false;
                });
              },
              scale: scale,
            ),

            SizedBox(height: 16 * scale),

            // ✅ الباسوورد
            _buildInputField(
              controller: _passwordController,
              hint: "Password *",
              icon: Icons.lock_outline,
              isPassword: true,
              error: _passwordError,
              errorText: "Password must be at least 6 characters",
              scale: scale,
            ),

            SizedBox(height: 16 * scale),

            // ✅ تأكيد الباسوورد
            _buildInputField(
              controller: _confirmPasswordController,
              hint: "Confirm Password *",
              icon: Icons.lock_outline,
              isPassword: true,
              error: _confirmPasswordError,
              errorText: "Passwords do not match",
              scale: scale,
            ),

            SizedBox(height: 30 * scale),

            // ✅ زر المتابعة
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _validateAllFields();
                  if (_canProceed()) {
                    Get.to(
                      () => MedicalInfoPage(
                        patientData: PatientBasicInfo(
                          name: _nameController.text,
                          email: _emailController.text,
                          phone: _phoneController.text,
                          birthDate: _selectedDate!,
                          gender: _selectedGender!,
                          password: _passwordController.text,
                        ),
                      ),
                    );
                  } else {
                    Get.snackbar(
                      'Validation Error',
                      'Please fix all errors before proceeding',
                      backgroundColor: AppColors.error.withOpacity(0.1),
                      colorText: AppColors.error,
                    );
                  }
                },
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
                  "Continue to Medical Info",
                  style: AppTextStyles.buttonMedium.copyWith(
                    fontSize: 16 * scale,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20 * scale),

            // ✅ تسجيل الدخول
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.greyDark,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back(); // ✅ GetX للعودة
                  },
                  child: Text(
                    "Login",
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
    bool error = false,
    String? errorText,
    TextInputType keyboardType = TextInputType.text,
    required double scale,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomInputField(
          controller: controller,
          hint: hint,
          icon: icon,
          isPassword: isPassword,
          hasError: error,
          keyboardType: keyboardType,
          scale: scale,
        ),
        if (error && errorText != null)
          Padding(
            padding: EdgeInsets.only(left: 16 * scale, top: 4 * scale),
            child: Text(
              errorText,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDateField({
    required DateTime? selectedDate,
    required VoidCallback onTap,
    required bool error,
    required String Function() calculateAge,
    required double scale,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: error
                ? AppColors.error.withOpacity(0.05)
                : AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(18 * scale),
            border: Border.all(
              color:
                  error ? AppColors.error : AppColors.primary.withOpacity(0.3),
            ),
          ),
          child: ListTile(
            leading: Icon(
              Icons.cake_outlined,
              size: 20 * scale,
              color: error ? AppColors.error : AppColors.primary,
            ),
            title: Text(
              selectedDate == null
                  ? "Birth Date *"
                  : "Age: ${calculateAge()} years",
              style: AppTextStyles.bodyMedium.copyWith(
                color: error ? AppColors.error : AppColors.primaryDark,
              ),
            ),
            subtitle: selectedDate != null
                ? Text(
                    "Born: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.greyDark,
                    ),
                  )
                : null,
            trailing: Icon(
              Icons.calendar_today,
              size: 18 * scale,
              color: error ? AppColors.error : AppColors.primary,
            ),
            onTap: onTap,
          ),
        ),
        if (error)
          Padding(
            padding: EdgeInsets.only(left: 16 * scale, top: 4 * scale),
            child: Text(
              "Please select your birth date",
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildGenderField({
    required String? selectedGender,
    required bool error,
    required Function(String?) onChanged,
    required double scale,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender *",
          style: AppTextStyles.bodyMedium.copyWith(
            color: error ? AppColors.error : AppColors.primaryDark,
            fontWeight: FontWeight.w500,
          ),
        ),

        SizedBox(height: 8 * scale),

        // ✅ تصميم أنظف - أزرار بجانب بعض
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12 * scale),
            border: Border.all(
              color: error ? AppColors.error : AppColors.greyLight,
              width: 1.5 * scale,
            ),
          ),
          padding: EdgeInsets.all(8 * scale),
          child: Row(
            children: [
              // زر Male
              Expanded(
                child: _buildGenderChip(
                  label: "Male",
                  isSelected: selectedGender == "Male",
                  onTap: () => onChanged("Male"),
                  scale: scale,
                  error: error,
                ),
              ),

              SizedBox(width: 8 * scale),

              // زر Female
              Expanded(
                child: _buildGenderChip(
                  label: "Female",
                  isSelected: selectedGender == "Female",
                  onTap: () => onChanged("Female"),
                  scale: scale,
                  error: error,
                ),
              ),
            ],
          ),
        ),

        if (error)
          Padding(
            padding: EdgeInsets.only(left: 8 * scale, top: 4 * scale),
            child: Text(
              "Please select your gender",
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildGenderChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required double scale,
    required bool error,
  }) {
    return Material(
      color: isSelected
          ? (error ? AppColors.error : AppColors.primary)
          : AppColors.greyLight.withOpacity(0.3),
      borderRadius: BorderRadius.circular(8 * scale),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8 * scale),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16 * scale,
            vertical: 14 * scale,
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isSelected ? AppColors.white : AppColors.greyDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}

class PatientBasicInfo {
  final String name;
  final String email;
  final String phone;
  final DateTime birthDate;
  final String gender;
  final String password;

  PatientBasicInfo({
    required this.name,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.gender,
    required this.password,
  });
}

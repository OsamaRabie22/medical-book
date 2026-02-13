import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/utils/validators.dart';
import '../../../models/patient_model.dart';
import '../../../services/api_service.dart'; // ✅ إضافة الاستيراد
import '../../../widgets/custom_input_field.dart';
import 'login_page.dart';
import 'medical_info_page.dart'; // ✅ للتوجيه بعد التسجيل

// ✅ List of Egyptian Cities in English
const List<String> egyptianCities = [
  'Cairo',
  'Alexandria',
  'Giza',
  'Shubra El Kheima',
  'Port Said',
  'Suez',
  'El Mahalla El Kubra',
  'Tanta',
  'Mansoura',
  'Asyut',
  'Zagazig',
  'Ismailia',
  'Kafr El Sheikh',
  'Damanhur',
  'Fayoum',
  'Qena',
  'Sohag',
  'Benha',
  'Minya',
  'Beni Suef',
  'Luxor',
  'Aswan',
  'Damietta',
  'Hurghada',
  'Sharm El Sheikh',
  'Marsa Matrouh',
  'Arish',
  'Khanka',
  'Qalyub',
  '10th of Ramadan',
  '6th of October',
  'Badr',
  'Shorouk',
  'Obour',
  'Hadayek October',
  'Borg El Arab',
  'Nuweiba',
  'Dahab',
  'Taba',
  'Ras Sedr',
  'El Tor',
  'Shalateen',
  'Halaib',
  'Abu Qir',
  'Edfu',
  'Kom Ombo',
  'Nasr Nuba',
  'Abu Simbel',
  'Desouk',
  'Fouh',
  'Baltim',
  'Metoubes',
  'Hawamdeya',
  'Saf',
  'Ayat',
  'Atfih',
  'Bahariya Oasis',
  'Dakhla Oasis',
  'Kharga Oasis',
  'Sinnuris',
  'Tamiya',
  'Abshaway',
  'Youssef El Seddik',
  'Itsa',
  'Maghagha',
  'Beni Mazar',
  'Matay',
  'Samalut',
  'Abu Qurqas',
  'Mallawi',
  'Deir Mawas',
  'El Adwa',
  'Manfalut',
  'Abnub',
  'Abu Tij',
  'El Ghanayem',
  'Sedfa',
  'Tahta',
  'Gerga',
  'El Balyana',
  'El Maragha',
  'El Monshah',
  'Saqultah',
  'Akhmim',
  'Dar El Salam',
  'Naqada',
  'Qus',
  'Luxor',
  'El Tod',
  'Armant',
  'Esna',
  'Edfu',
  'El Sabaiya',
  'Kom Ombo',
  'Daraw',
  'Nasr Nuba',
  'Kalabsha',
  'El Reidah',
  'Ras Gharib',
  'Safaga',
  'El Quseir',
  'Marsa Alam',
  'Shalateen',
  'Halaib',
];

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
  bool _isMarried = false;
  String? _selectedCity;

  // Validation errors
  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _cityError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _genderError;
  String? _birthDateError;

  final ApiService _apiService = ApiService(); // ✅ Instantiate ApiService
  bool _isLoading = false; // ✅ Loading state

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthDateError = null;
      });
    }
  }

  void _validateAllFields() {
    setState(() {
      _nameError = Validators.validateName(_nameController.text);
      _emailError = Validators.validateEmail(_emailController.text);
      _phoneError = Validators.validatePhone(_phoneController.text);
      _cityError = _selectedCity == null ? 'Please select your city' : null;
      _passwordError = Validators.validatePassword(_passwordController.text);
      _confirmPasswordError = Validators.validateConfirmPassword(
        _passwordController.text,
        _confirmPasswordController.text,
      );
      _genderError = Validators.validateGender(_selectedGender);
      _birthDateError = Validators.validateBirthDate(_selectedDate);
    });
  }

  bool _canProceed() {
    return _nameError == null &&
        _emailError == null &&
        _phoneError == null &&
        _cityError == null &&
        _passwordError == null &&
        _confirmPasswordError == null &&
        _genderError == null &&
        _birthDateError == null;
  }

  // ✅ دالة التسجيل
  Future<void> _register() async {
    _validateAllFields();

    if (!_canProceed()) {
      Get.snackbar(
        'Validation Error',
        'Please fix all errors before proceeding',
        backgroundColor: AppColors.error.withOpacity(0.1),
        colorText: AppColors.error,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Create patient object
      final patient = Patient(
        patientName: _nameController.text,
        patientAge: Validators.calculateAge(_selectedDate!),
        patientGender: Validators.formatGenderForApi(_selectedGender!),
        patientCity: _selectedCity!,
        patientEmail: _emailController.text,
        patientPassword: _passwordController.text,
        patientMarried: _isMarried,
        patientPhone: _phoneController.text,
        patientImage: null,
      );

      // Call API
      final response = await _apiService.registerPatient(patient.toSignupJson());

      // ✅ Debug prints
      print("Response status: ${response.statusCode}");
      print("Response headers: ${response.headers}");
      print("Response data type: ${response.data.runtimeType}");
      print("Response data keys: ${response.data is Map ? response.data.keys : 'Not a Map'}");
      print("Response data: ${response.data}");

      // في signup_page.dart، في دالة _register:

      if (response.statusCode == 200 || response.statusCode == 201) {
        // ✅ استخراج patientId من الاستجابة
        int? patientId;

        if (response.data is Map) {
          // جرب أكتر من طريقة عشان نجيب الـ ID
          patientId = response.data['patient_id'] ??
              response.data['id'] ??
              response.data['userId'] ??
              response.data['user_id'];

          // لو البيانات جوه key تاني
          if (patientId == null && response.data['data'] != null) {
            patientId = response.data['data']['patient_id'] ??
                response.data['data']['id'];
          }
        }

        print("Extracted patientId: $patientId");

        // ✅ حتى لو patientId == null، خلينا نكمل بصفة مؤقتة
        // ممكن نستخدم email أو حاجة كـ temporary ID
        final completePatient = Patient(
          patientId: patientId ?? 0, // لو null، استخدم 0 كـ temporary
          patientName: _nameController.text,
          patientAge: Validators.calculateAge(_selectedDate!),
          patientGender: Validators.formatGenderForApi(_selectedGender!),
          patientCity: _selectedCity!,
          patientEmail: _emailController.text,
          patientPassword: _passwordController.text,
          patientMarried: _isMarried,
          patientPhone: _phoneController.text,
          patientImage: null,
        );

        Get.off(() => MedicalInfoPage(patient: completePatient));
      } else {
        Get.snackbar(
          'Registration Failed',
          response.data['message'] ?? 'Please try again',
          backgroundColor: AppColors.error.withOpacity(0.1),
          colorText: AppColors.error,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("Error during registration: $e");
      Get.snackbar(
        'Error',
        'An error occurred during registration. Please check your connection.',
        backgroundColor: AppColors.error.withOpacity(0.1),
        colorText: AppColors.error,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
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

                // Avatar
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
                  "Fill in your information to register",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 30 * scale),

                // Full Name
                _buildInputField(
                  controller: _nameController,
                  hint: "Full Name *",
                  icon: Icons.person_outline,
                  error: _nameError,
                  onChanged: (value) {
                    setState(() {
                      _nameError = Validators.validateName(value);
                    });
                  },
                  scale: scale,
                ),

                SizedBox(height: 16 * scale),

                // Email
                _buildInputField(
                  controller: _emailController,
                  hint: "Email Address *",
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

                // Phone
                _buildInputField(
                  controller: _phoneController,
                  hint: "Phone Number * (01xxxxxxxxx)",
                  icon: Icons.phone_outlined,
                  error: _phoneError,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    setState(() {
                      _phoneError = Validators.validatePhone(value);
                    });
                  },
                  scale: scale,
                ),

                SizedBox(height: 16 * scale),

                // City Dropdown Field
                _buildCityField(
                  selectedCity: _selectedCity,
                  error: _cityError,
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value;
                      _cityError = null;
                    });
                  },
                  scale: scale,
                ),

                SizedBox(height: 16 * scale),

                // Birth Date
                _buildDateField(
                  selectedDate: _selectedDate,
                  onTap: _selectDate,
                  error: _birthDateError,
                  scale: scale,
                ),

                SizedBox(height: 16 * scale),

                // Gender
                _buildGenderField(
                  selectedGender: _selectedGender,
                  error: _genderError,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                      _genderError = Validators.validateGender(value);
                    });
                  },
                  scale: scale,
                ),

                SizedBox(height: 16 * scale),

                // Marital Status
                _buildMaritalStatusField(
                  isMarried: _isMarried,
                  onChanged: (value) {
                    setState(() {
                      _isMarried = value;
                    });
                  },
                  scale: scale,
                ),

                SizedBox(height: 16 * scale),

                // Password
                _buildInputField(
                  controller: _passwordController,
                  hint: "Password * (6-25 characters)",
                  icon: Icons.lock_outline,
                  isPassword: true,
                  error: _passwordError,
                  onChanged: (value) {
                    setState(() {
                      _passwordError = Validators.validatePassword(value);
                      _confirmPasswordError = Validators.validateConfirmPassword(
                        value,
                        _confirmPasswordController.text,
                      );
                    });
                  },
                  scale: scale,
                ),

                SizedBox(height: 16 * scale),

                // Confirm Password
                _buildInputField(
                  controller: _confirmPasswordController,
                  hint: "Confirm Password *",
                  icon: Icons.lock_outline,
                  isPassword: true,
                  error: _confirmPasswordError,
                  onChanged: (value) {
                    setState(() {
                      _confirmPasswordError = Validators.validateConfirmPassword(
                        _passwordController.text,
                        value,
                      );
                    });
                  },
                  scale: scale,
                ),

                SizedBox(height: 30 * scale),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.symmetric(vertical: 16 * scale),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14 * scale),
                      ),
                      elevation: 4,
                    ),
                    child: _isLoading
                        ? SizedBox(
                      height: 20 * scale,
                      width: 20 * scale,
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : Text(
                      "Register",
                      style: AppTextStyles.buttonMedium.copyWith(
                        fontSize: 18 * scale,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20 * scale),

                // Login Link
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
                        Get.off(() => LoginPage());
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
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20 * scale),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12 * scale),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 16 * scale),
                      Text(
                        "Creating account...",
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // City Dropdown Field
  Widget _buildCityField({
    required String? selectedCity,
    required String? error,
    required Function(String?) onChanged,
    required double scale,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "City *",
          style: AppTextStyles.bodyMedium.copyWith(
            color: error != null ? AppColors.error : AppColors.primaryDark,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8 * scale),
        Container(
          decoration: BoxDecoration(
            color: error != null
                ? AppColors.error.withOpacity(0.05)
                : AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(18 * scale),
            border: Border.all(
              color: error != null
                  ? AppColors.error
                  : AppColors.primary.withOpacity(0.3),
              width: 1.5 * scale,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16 * scale),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCity,
              hint: Text(
                "Select your city",
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.grey,
                ),
              ),
              isExpanded: true,
              icon: Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: error != null ? AppColors.error : AppColors.primary,
                size: 22 * scale,
              ),
              items: egyptianCities.map((city) {
                return DropdownMenuItem(
                  value: city,
                  child: Text(
                    city,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              dropdownColor: AppColors.white,
              borderRadius: BorderRadius.circular(12 * scale),
            ),
          ),
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

  Widget _buildDateField({
    required DateTime? selectedDate,
    required VoidCallback onTap,
    required String? error,
    required double scale,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: error != null
                ? AppColors.error.withOpacity(0.05)
                : AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(18 * scale),
            border: Border.all(
              color: error != null
                  ? AppColors.error
                  : AppColors.primary.withOpacity(0.3),
            ),
          ),
          child: ListTile(
            leading: Icon(
              Icons.cake_outlined,
              size: 20 * scale,
              color: error != null ? AppColors.error : AppColors.primary,
            ),
            title: Text(
              selectedDate == null
                  ? "Birth Date *"
                  : "Age: ${Validators.calculateAge(selectedDate)} years",
              style: AppTextStyles.bodyMedium.copyWith(
                color: error != null ? AppColors.error : AppColors.primaryDark,
              ),
            ),
            subtitle: selectedDate != null
                ? Text(
              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.greyDark,
              ),
            )
                : null,
            trailing: Icon(
              Icons.calendar_today,
              size: 18 * scale,
              color: error != null ? AppColors.error : AppColors.primary,
            ),
            onTap: onTap,
          ),
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

  Widget _buildGenderField({
    required String? selectedGender,
    required String? error,
    required Function(String?) onChanged,
    required double scale,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender *",
          style: AppTextStyles.bodyMedium.copyWith(
            color: error != null ? AppColors.error : AppColors.primaryDark,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8 * scale),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12 * scale),
            border: Border.all(
              color: error != null ? AppColors.error : AppColors.greyLight,
              width: 1.5 * scale,
            ),
          ),
          padding: EdgeInsets.all(8 * scale),
          child: Row(
            children: [
              Expanded(
                child: _buildGenderChip(
                  label: "Male",
                  isSelected: selectedGender == "Male",
                  onTap: () => onChanged("Male"),
                  scale: scale,
                  error: error != null,
                ),
              ),
              SizedBox(width: 8 * scale),
              Expanded(
                child: _buildGenderChip(
                  label: "Female",
                  isSelected: selectedGender == "Female",
                  onTap: () => onChanged("Female"),
                  scale: scale,
                  error: error != null,
                ),
              ),
            ],
          ),
        ),
        if (error != null)
          Padding(
            padding: EdgeInsets.only(left: 8 * scale, top: 4 * scale),
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

  Widget _buildMaritalStatusField({
    required bool isMarried,
    required Function(bool) onChanged,
    required double scale,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
        ),
      ),
      child: ListTile(
        leading: Icon(
          isMarried ? Icons.family_restroom : Icons.person,
          color: AppColors.primary,
          size: 20 * scale,
        ),
        title: Text(
          "Marital Status",
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.primaryDark,
          ),
        ),
        trailing: Switch(
          value: isMarried,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
        subtitle: Text(
          isMarried ? "Married" : "Single",
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.greyDark,
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
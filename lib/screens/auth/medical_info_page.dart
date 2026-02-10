
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/responsive_utils.dart';
import '../home/home_page.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/custom_input_field.dart';
import 'signup_page.dart';

class MedicalInfoPage extends StatefulWidget {
  final PatientBasicInfo patientData;

  const MedicalInfoPage({super.key, required this.patientData});

  @override
  State<MedicalInfoPage> createState() => _MedicalInfoPageState();
}

class _MedicalInfoPageState extends State<MedicalInfoPage> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  String? _selectedBloodType;
  String? _selectedResidenceType;
  String? _selectedCity;
  bool _hasHypertension = false;
  bool _hasDiabetes = false;
  bool _hasAnemia = false;
  bool _isMarried = false;

  final List<String> _bloodTypes = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
  ];

  final List<String> _egyptGovernorates = [
    'Cairo', 'Alexandria', 'Port Said', 'Suez', 'Damietta', 'Dakahlia',
    'Sharqia', 'Qalyubia', 'Kafr El Sheikh', 'Gharbia', 'Monufia', 'Beheira',
    'Ismailia', 'Giza', 'Beni Suef', 'Faiyum', 'Minya', 'Asyut', 'Sohag',
    'Qena', 'Aswan', 'Luxor', 'Red Sea', 'New Valley', 'Matrouh',
    'North Sinai', 'South Sinai'
  ];

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 40 : 28 * scale,
            vertical: 20 * scale,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15 * scale),
                const Center(child: AppLogo()),
                SizedBox(height: 10 * scale),

                // ✅ Skip Message
                Center(
                  child: Text(
                    "You can skip and complete later from your profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isTablet ? 16 : 14 * scale,
                      color: AppColors.greyDark,
                    ),
                  ),
                ),
                SizedBox(height: 25 * scale),

                // ✅ Demographic Information
                _buildSectionTitle(
                  "Demographic Information (Optional)",
                  scale,
                  isTablet,
                ),
                SizedBox(height: 16 * scale),

                // ✅ City Dropdown
                _buildDropdownField(
                  value: _selectedCity,
                  hint: "City",
                  icon: Icons.location_city_outlined,
                  items: _egyptGovernorates,
                  onChanged: (value) => setState(() => _selectedCity = value),
                  scale: scale,
                  isTablet: isTablet,
                ),
                SizedBox(height: 16 * scale),

                // ✅ Blood Type Dropdown
                _buildDropdownField(
                  value: _selectedBloodType,
                  hint: "Blood Type",
                  icon: Icons.bloodtype_outlined,
                  items: _bloodTypes,
                  onChanged: (value) => setState(() => _selectedBloodType = value),
                  scale: scale,
                  isTablet: isTablet,
                ),
                SizedBox(height: 16 * scale),

                // ✅ Residence Type Dropdown
                _buildDropdownField(
                  value: _selectedResidenceType,
                  hint: "Residence Type",
                  icon: Icons.home_outlined,
                  items: ['Urban', 'Rural'],
                  onChanged: (value) => setState(() => _selectedResidenceType = value),
                  scale: scale,
                  isTablet: isTablet,
                ),

                SizedBox(height: 25 * scale),

                // ✅ Social Information
                _buildSectionTitle(
                  "Social Information (Optional)",
                  scale,
                  isTablet,
                ),
                SizedBox(height: 16 * scale),

                // ✅ Married Status
                _buildConditionSwitch(
                  "Married",
                  _isMarried,
                  Icons.family_restroom_outlined,
                      (value) => setState(() => _isMarried = value),
                  scale,
                  isTablet,
                ),

                SizedBox(height: 25 * scale),

                // ✅ Body Measurements
                _buildSectionTitle(
                  "Body Measurements (Optional)",
                  scale,
                  isTablet,
                ),
                SizedBox(height: 16 * scale),

                // ✅ Height and Weight in Row for tablets, Column for mobile
                if (isTablet)
                  Row(
                    children: [
                      Expanded(
                        child: CustomInputField(
                          controller: _heightController,
                          hint: "Height (cm)",
                          icon: Icons.height_outlined,
                          scale: scale,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: 16 * scale),
                      Expanded(
                        child: CustomInputField(
                          controller: _weightController,
                          hint: "Weight (kg)",
                          icon: Icons.monitor_weight_outlined,
                          scale: scale,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      CustomInputField(
                        controller: _heightController,
                        hint: "Height (cm)",
                        icon: Icons.height_outlined,
                        scale: scale,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16 * scale),
                      CustomInputField(
                        controller: _weightController,
                        hint: "Weight (kg)",
                        icon: Icons.monitor_weight_outlined,
                        scale: scale,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),

                SizedBox(height: 25 * scale),

                // ✅ Chronic Conditions
                _buildSectionTitle(
                  "Chronic Conditions (Optional)",
                  scale,
                  isTablet,
                ),
                SizedBox(height: 12 * scale),

                _buildConditionSwitch(
                  "Hypertension",
                  _hasHypertension,
                  Icons.monitor_heart_outlined,
                      (value) => setState(() => _hasHypertension = value),
                  scale,
                  isTablet,
                ),
                _buildConditionSwitch(
                  "Diabetes",
                  _hasDiabetes,
                  Icons.bloodtype_outlined,
                      (value) => setState(() => _hasDiabetes = value),
                  scale,
                  isTablet,
                ),
                _buildConditionSwitch(
                  "Anemia",
                  _hasAnemia,
                  Icons.air_outlined,
                      (value) => setState(() => _hasAnemia = value),
                  scale,
                  isTablet,
                ),

                SizedBox(height: 40 * scale),

                // ✅ Complete Registration Button
                _buildCompleteButton(scale, isTablet),

                SizedBox(height: 20 * scale),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, double scale, bool isTablet) {
    return Text(
      title,
      style: TextStyle(
        fontSize: isTablet ? 18 : 16 * scale,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryDark,
      ),
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required String hint,
    required IconData icon,
    required List<String> items,
    required Function(String?) onChanged,
    required double scale,
    required bool isTablet,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18 * scale),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.3),
          width: 1 * scale,
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            icon,
            size: isTablet ? 24 : 20 * scale,
            color: AppColors.primary,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: isTablet ? 16 : 14 * scale,
            color: AppColors.grey,
          ),
          contentPadding: EdgeInsets.all(16 * scale),
        ),
        icon: Icon(
          Icons.arrow_drop_down,
          size: isTablet ? 24 : 20 * scale,
          color: AppColors.grey,
        ),
        dropdownColor: Colors.white,
        style: TextStyle(
          fontSize: isTablet ? 16 : 14 * scale,
          color: AppColors.primaryDark,
        ),
        items: items
            .map((item) => DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: TextStyle(fontSize: isTablet ? 16 : 14 * scale),
          ),
        ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildConditionSwitch(
      String title,
      bool value,
      IconData icon,
      Function(bool) onChanged,
      double scale,
      bool isTablet,
      ) {
    return Card(
      margin: EdgeInsets.only(bottom: 8 * scale),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12 * scale),
      ),
      child: SwitchListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: isTablet ? 16 : 14 * scale,
            fontWeight: FontWeight.w500,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
        inactiveThumbColor: AppColors.greyLight,
        inactiveTrackColor: AppColors.grey.withOpacity(0.5),
        secondary: Icon(
          icon,
          color: AppColors.primary,
          size: isTablet ? 24 : 20 * scale,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16 * scale,
          vertical: 4 * scale,
        ),
      ),
    );
  }

  Widget _buildCompleteButton(double scale, bool isTablet) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _completeRegistration,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14 * scale),
          ),
          padding: EdgeInsets.symmetric(vertical: isTablet ? 20 : 16 * scale),
          elevation: 4,
        ),
        child: Text(
          "Complete Registration",
          style: TextStyle(
            fontSize: isTablet ? 18 : 16 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _completeRegistration() {
    // جمع البيانات وإرسالها للـ backend
    final patientFullData = {
      'basic_info': widget.patientData,
      'medical_info': {
        'city': _selectedCity,
        'blood_type': _selectedBloodType,
        'residence_type': _selectedResidenceType,
        'height': _heightController.text,
        'weight': _weightController.text,
        'is_married': _isMarried,
        'conditions': {
          'hypertension': _hasHypertension,
          'diabetes': _hasDiabetes,
          'anemia': _hasAnemia,
        },
      },
    };

    print('Patient Data: $patientFullData');

    Get.snackbar(
      'Registration Complete!',
      'Welcome ${widget.patientData.name}',
      backgroundColor: AppColors.success.withOpacity(0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );

    // التوجيه للصفحة الرئيسية
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(const HomePage());
    });
  }
}
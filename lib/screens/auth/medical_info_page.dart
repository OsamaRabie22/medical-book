// [file name]: lib/screens/auth/medical_info_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/utils/validators.dart';
import '../../../models/patient_model.dart';
import '../../../models/sick_record_model.dart';
import '../../../providers/patient_provider.dart';
import '../../../services/api_service.dart';
import '../../../widgets/custom_input_field.dart';
import '../home/home_page.dart';

class MedicalInfoPage extends StatefulWidget {
  final Patient patient;

  const MedicalInfoPage({
    super.key,
    required this.patient,
  });

  @override
  State<MedicalInfoPage> createState() => _MedicalInfoPageState();
}

class _MedicalInfoPageState extends State<MedicalInfoPage> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  String? _selectedBloodType;
  bool _hasAnaemia = false;
  bool _hasHypertension = false;
  bool _hasDiabetes = false;
  bool _residenceType = true; // true = Urban, false = Rural

  // Validation errors
  String? _heightError;
  String? _weightError;
  String? _bloodTypeError;

  final List<String> _bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  void _validateAllFields() {
    setState(() {
      _heightError = _heightController.text.isNotEmpty
          ? Validators.validateHeight(_heightController.text)
          : null;
      _weightError = _weightController.text.isNotEmpty
          ? Validators.validateWeight(_weightController.text)
          : null;
      _bloodTypeError = _selectedBloodType != null
          ? Validators.validateBloodType(_selectedBloodType)
          : null;
    });
  }

  bool _hasValidData() {
    if (_heightController.text.isNotEmpty && _heightError != null) return false;
    if (_weightController.text.isNotEmpty && _weightError != null) return false;
    if (_selectedBloodType != null && _bloodTypeError != null) return false;
    return true;
  }

  // ✅ دالة إنشاء sick record
  Future<void> _createSickRecord() async {
    _validateAllFields();

    if (!_hasValidData()) {
      Get.snackbar(
        'Validation Error',
        'Please fix errors in the data you entered',
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
      // ✅ جلب الـ PatientProvider
      final patientProvider =
          Provider.of<PatientProvider>(context, listen: false);

      // ✅ تحديث البيانات مع المعلومات الطبية
      final updatedPatient = widget.patient.copyWithMedicalInfo(
        patientHeight: _heightController.text.isNotEmpty
            ? double.tryParse(_heightController.text)
            : null,
        patientWeight: _weightController.text.isNotEmpty
            ? double.tryParse(_weightController.text)
            : null,
        patientBloodType: _selectedBloodType,
      );

      print("==========================================");
      print("✅ Updating Patient in Provider:");
      print("   - ID: ${updatedPatient.patientId}");
      print("   - Name: ${updatedPatient.patientName}");
      print("   - Email: ${updatedPatient.patientEmail}");
      if (updatedPatient.patientHeight != null) {
        print("   - Height: ${updatedPatient.patientHeight}");
      }
      if (updatedPatient.patientWeight != null) {
        print("   - Weight: ${updatedPatient.patientWeight}");
      }
      if (updatedPatient.patientBloodType != null) {
        print("   - Blood Type: ${updatedPatient.patientBloodType}");
      }
      print("==========================================");

      // ✅ حفظ البيانات المحدثة في Provider
      patientProvider.updatePatient(updatedPatient);

      // ✅ التحقق من وجود بيانات كافية لإرسالها إلى API sick-record
      bool hasMedicalData = _heightController.text.isNotEmpty &&
          _weightController.text.isNotEmpty &&
          _selectedBloodType != null;

      if (hasMedicalData &&
          widget.patient.patientId != null &&
          widget.patient.patientId! > 0) {
        try {
          // ✅ إنشاء sick record
          final sickRecord = SickRecord(
            patientId: widget.patient.patientId!,
            patientHeight: int.parse(_heightController.text),
            patientWeight: int.parse(_weightController.text),
            patientAnaemia: _hasAnaemia,
            patientHypertension: _hasHypertension,
            patientDiabetes: _hasDiabetes,
            residenceType: _residenceType ? "urban" : "rural",
            patientBloodType: _selectedBloodType!,
          );

          print("📤 Sending sick record to API: ${sickRecord.toCreateJson()}");

          // ✅ استدعاء API
          final response =
              await _apiService.createSickRecord(sickRecord.toCreateJson());

          if (response.statusCode == 200 || response.statusCode == 201) {
            print("✅ Sick record saved successfully");
            Get.snackbar(
              'Success',
              'Medical information saved successfully!',
              backgroundColor: AppColors.success.withOpacity(0.1),
              colorText: AppColors.success,
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 2),
            );
          } else {
            print("⚠️ Sick record API returned: ${response.statusCode}");
            print("⚠️ Response data: ${response.data}");
            Get.snackbar(
              'Warning',
              'Profile saved, but medical record failed to save on server.',
              backgroundColor: AppColors.warning.withOpacity(0.1),
              colorText: AppColors.warning,
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 3),
            );
          }
        } catch (e) {
          print("💥 Error sending sick record to API: $e");
          Get.snackbar(
            'Warning',
            'Profile saved locally, but could not connect to server.',
            backgroundColor: AppColors.warning.withOpacity(0.1),
            colorText: AppColors.warning,
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 3),
          );
        }
      } else {
        if (_heightController.text.isNotEmpty ||
            _weightController.text.isNotEmpty ||
            _selectedBloodType != null) {
          Get.snackbar(
            'Info',
            'Partial medical data saved locally.',
            backgroundColor: AppColors.info.withOpacity(0.1),
            colorText: AppColors.info,
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );
        } else {
          Get.snackbar(
            'Success',
            'Profile completed successfully!',
            backgroundColor: AppColors.success.withOpacity(0.1),
            colorText: AppColors.success,
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );
        }
      }

      // ✅ الانتقال إلى الصفحة الرئيسية
      Get.offAll(const HomePage());
    } catch (e) {
      print("💥 Error in _createSickRecord: $e");
      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
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
      appBar: AppBar(
        title: Text(
          "Medical Information",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 20 * scale,
            color: AppColors.primaryDark,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primaryDark,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20 * scale,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // ✅ Skip: احفظ البيانات الأساسية فقط
              final patientProvider =
                  Provider.of<PatientProvider>(context, listen: false);
              patientProvider.updatePatient(widget.patient);
              print("⚠️ User skipped medical info - saved basic data only");

              Get.snackbar(
                'Info',
                'Profile saved with basic information.',
                backgroundColor: AppColors.info.withOpacity(0.1),
                colorText: AppColors.info,
                snackPosition: SnackPosition.BOTTOM,
                duration: Duration(seconds: 2),
              );

              Get.offAll(const HomePage());
            },
            child: Text(
              "Skip",
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(20 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Patient Summary Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16 * scale),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16 * scale),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: AppColors.primary,
                            size: 20 * scale,
                          ),
                          SizedBox(width: 8 * scale),
                          Text(
                            widget.patient.patientName ?? 'No Name',
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8 * scale),
                      Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            color: AppColors.primary,
                            size: 16 * scale,
                          ),
                          SizedBox(width: 8 * scale),
                          Text(
                            widget.patient.patientEmail ?? 'No Email',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.greyDark,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4 * scale),
                      Row(
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            color: AppColors.primary,
                            size: 16 * scale,
                          ),
                          SizedBox(width: 8 * scale),
                          Text(
                            widget.patient.patientPhone ?? 'No Phone',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.greyDark,
                            ),
                          ),
                        ],
                      ),
                      if (widget.patient.patientId != null &&
                          widget.patient.patientId != 0) ...[
                        SizedBox(height: 4 * scale),
                        Row(
                          children: [
                            Icon(
                              Icons.badge,
                              color: AppColors.primary,
                              size: 16 * scale,
                            ),
                            SizedBox(width: 8 * scale),
                            Text(
                              'ID: ${widget.patient.patientId}',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                SizedBox(height: 24 * scale),

                Text(
                  "Step 2: Health Information (Optional)",
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontSize: 18 * scale,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryDark,
                  ),
                ),
                SizedBox(height: 8 * scale),
                Text(
                  "You can skip this step and add it later",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.greyDark,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                SizedBox(height: 24 * scale),

                // Height & Weight Row
                Row(
                  children: [
                    // Height
                    Expanded(
                      child: _buildInputField(
                        controller: _heightController,
                        hint: "Height (cm) - Optional",
                        icon: Icons.height,
                        error: _heightError,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _heightError = value.isNotEmpty
                                ? Validators.validateHeight(value)
                                : null;
                          });
                        },
                        scale: scale,
                      ),
                    ),
                    SizedBox(width: 16 * scale),
                    // Weight
                    Expanded(
                      child: _buildInputField(
                        controller: _weightController,
                        hint: "Weight (kg) - Optional",
                        icon: Icons.monitor_weight,
                        error: _weightError,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _weightError = value.isNotEmpty
                                ? Validators.validateWeight(value)
                                : null;
                          });
                        },
                        scale: scale,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16 * scale),

                // Blood Type
                _buildBloodTypeField(
                  selectedBloodType: _selectedBloodType,
                  error: _bloodTypeError,
                  onChanged: (value) {
                    setState(() {
                      _selectedBloodType = value;
                      _bloodTypeError = value != null
                          ? Validators.validateBloodType(value)
                          : null;
                    });
                  },
                  scale: scale,
                ),

                SizedBox(height: 16 * scale),

                // Residence Type
                _buildResidenceField(
                  isUrban: _residenceType,
                  onChanged: (value) {
                    setState(() {
                      _residenceType = value;
                    });
                  },
                  scale: scale,
                ),

                SizedBox(height: 24 * scale),

                // Medical Conditions
                Text(
                  "Medical Conditions",
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDark,
                  ),
                ),
                SizedBox(height: 12 * scale),

                _buildCheckboxTile(
                  title: "Anaemia",
                  value: _hasAnaemia,
                  onChanged: (value) {
                    setState(() {
                      _hasAnaemia = value ?? false;
                    });
                  },
                  scale: scale,
                ),
                _buildCheckboxTile(
                  title: "Hypertension",
                  value: _hasHypertension,
                  onChanged: (value) {
                    setState(() {
                      _hasHypertension = value ?? false;
                    });
                  },
                  scale: scale,
                ),
                _buildCheckboxTile(
                  title: "Diabetes",
                  value: _hasDiabetes,
                  onChanged: (value) {
                    setState(() {
                      _hasDiabetes = value ?? false;
                    });
                  },
                  scale: scale,
                ),

                SizedBox(height: 32 * scale),

                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _createSickRecord,
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
                            "Continue to Home",
                            style: AppTextStyles.buttonMedium.copyWith(
                              fontSize: 18 * scale,
                            ),
                          ),
                  ),
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
                        "Saving...",
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
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
          hasError: error != null,
          keyboardType: keyboardType,
          onChanged: onChanged,
          scale: scale,
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

  Widget _buildBloodTypeField({
    required String? selectedBloodType,
    required String? error,
    required Function(String?) onChanged,
    required double scale,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Blood Type (Optional)",
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
          padding: EdgeInsets.symmetric(horizontal: 16 * scale),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedBloodType,
              hint: Text(
                "Select Blood Type",
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.grey,
                ),
              ),
              isExpanded: true,
              icon: Icon(
                Icons.arrow_drop_down,
                color: error != null ? AppColors.error : AppColors.primary,
                size: 24 * scale,
              ),
              items: _bloodTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(
                    type,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
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

  Widget _buildResidenceField({
    required bool isUrban,
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
          isUrban ? Icons.location_city : Icons.house,
          color: AppColors.primary,
          size: 20 * scale,
        ),
        title: Text(
          "Residence Type",
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.primaryDark,
          ),
        ),
        trailing: Switch(
          value: isUrban,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
        subtitle: Text(
          isUrban ? "Urban" : "Rural",
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.greyDark,
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxTile({
    required String title,
    required bool value,
    required Function(bool?) onChanged,
    required double scale,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8 * scale),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(
          color: AppColors.greyLight.withOpacity(0.3),
        ),
      ),
      child: CheckboxListTile(
        title: Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.primaryDark,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16 * scale,
          vertical: 4 * scale,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}

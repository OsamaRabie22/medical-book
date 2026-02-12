import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/utils/validators.dart';
import '../../../models/patient_model.dart';
import '../../../models/sick_record_model.dart';
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
  final _notesController = TextEditingController();

  String? _selectedBloodType;
  bool _hasAnaemia = false;
  bool _hasHypertension = false;
  bool _hasDiabetes = false;
  bool _residenceType = true; // true = Urban, false = Rural

  // Validation errors
  String? _heightError;
  String? _weightError;
  String? _bloodTypeError;
  String? _notesError;

  final List<String> _bloodTypes = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
  ];

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);

    void _validateAllFields() {
      setState(() {
        _heightError = Validators.validateHeight(_heightController.text);
        _weightError = Validators.validateWeight(_weightController.text);
        _bloodTypeError = Validators.validateBloodType(_selectedBloodType);
        _notesError = Validators.validateNotes(_notesController.text);
      });
    }

    bool _canProceed() {
      return _heightError == null &&
          _weightError == null &&
          _bloodTypeError == null &&
          _notesError == null;
    }

    void _createSickRecord() {
      final sickRecord = SickRecord(
        patientHeight: int.parse(_heightController.text),
        patientWeight: int.parse(_weightController.text),
        patientAnaemia: _hasAnaemia,
        patientHypertension: _hasHypertension,
        patientDiabetes: _hasDiabetes,
        residenceType: _residenceType,
        patientBloodType: _selectedBloodType!,
        patientId: widget.patient.patientId ?? 0, // Will be assigned by API
        doctorId: null,
        diseaseId: null,
        appointmentId: null,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
      );

      // TODO: Send signup request with widget.patient.toSignupJson()
      // TODO: Send sick record with sickRecord.toCreateJson()

      print('Patient Data: ${widget.patient.toSignupJson()}');
      print('Sick Record Data: ${sickRecord.toCreateJson()}');

      Get.offAll(const HomePage());
    }

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
      ),
      body: SingleChildScrollView(
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
                        widget.patient.patientName,
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
                        widget.patient.patientEmail,
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
                        widget.patient.patientPhone,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.greyDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24 * scale),

            Text(
              "Step 2: Health Information",
              style: AppTextStyles.headlineSmall.copyWith(
                fontSize: 18 * scale,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
              ),
            ),
            SizedBox(height: 8 * scale),
            Text(
              "Please provide your medical details",
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.greyDark,
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
                    hint: "Height (cm)",
                    icon: Icons.height,
                    error: _heightError,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _heightError = Validators.validateHeight(value);
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
                    hint: "Weight (kg)",
                    icon: Icons.monitor_weight,
                    error: _weightError,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _weightError = Validators.validateWeight(value);
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
                  _bloodTypeError = Validators.validateBloodType(value);
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

            SizedBox(height: 24 * scale),

            // Notes
            _buildNotesField(
              controller: _notesController,
              error: _notesError,
              onChanged: (value) {
                setState(() {
                  _notesError = Validators.validateNotes(value);
                });
              },
              scale: scale,
            ),

            SizedBox(height: 32 * scale),

            // Create Account Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _validateAllFields();
                  if (_canProceed()) {
                    _createSickRecord();
                  } else {
                    Get.snackbar(
                      'Validation Error',
                      'Please fix all errors before proceeding',
                      backgroundColor: AppColors.error.withOpacity(0.1),
                      colorText: AppColors.error,
                      snackPosition: SnackPosition.BOTTOM,
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
                  "Create Account",
                  style: AppTextStyles.buttonMedium.copyWith(
                    fontSize: 18 * scale,
                  ),
                ),
              ),
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
          "Blood Type *",
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

  Widget _buildNotesField({
    required TextEditingController controller,
    required String? error,
    required Function(String) onChanged,
    required double scale,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Additional Notes",
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
          child: TextField(
            controller: controller,
            maxLines: 4,
            maxLength: 500,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: "Any additional medical notes...",
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.grey,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16 * scale),
              counterStyle: AppTextStyles.bodySmall.copyWith(
                color: AppColors.grey,
              ),
            ),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primaryDark,
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

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
// [file name]: lib/models/sick_record_model.dart

class SickRecord {
  final int patientId;
  final int patientHeight; // API uses pationt_Hight (typo)
  final int patientWeight; // API uses pationt_weight
  final bool patientAnaemia;
  final bool patientHypertension;
  final bool patientDiabetes;
  final String residenceType; // "urban" or "rural"
  final String patientBloodType;

  SickRecord({
    required this.patientId,
    required this.patientHeight,
    required this.patientWeight,
    required this.patientAnaemia,
    required this.patientHypertension,
    required this.patientDiabetes,
    required this.residenceType,
    required this.patientBloodType,
  });

  // Convert to JSON for API (matching the exact format)
  Map<String, dynamic> toCreateJson() {
    return {
      'patient_id': patientId,
      'pationt_Hight': patientHeight, // Note the typo in API
      'pationt_weight': patientWeight, // Note the typo in API
      'patient_anaemia': patientAnaemia,
      'patient_hypertension': patientHypertension,
      'patient_diabetes': patientDiabetes,
      'residence_type': residenceType, // API expects lowercase
      'patient_bloodtype': patientBloodType,
    };
  }
}
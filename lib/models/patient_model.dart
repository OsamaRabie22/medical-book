// [file name]: lib/models/patient_model.dart

class Patient {
  final int? patientId; // ✅ إضافة هذا
  final String? patientName;
  final int? patientAge;
  final String? patientGender;
  final String? patientCity;
  final String? patientEmail;
  final String? patientPassword;
  final bool? patientMarried;
  final String? patientPhone;
  final String? patientImage;

  // Medical Info
  final double? patientHeight;
  final double? patientWeight;
  final String? patientBloodType;
  final List<String>? patientChronicDiseases;
  final List<String>? patientAllergies;
  final List<String>? patientMedications;
  final List<String>? patientVaccinations;
  final List<Map<String, dynamic>>? patientSurgeries;
  final List<Map<String, dynamic>>? patientFamilyHistory;

  Patient({
    this.patientId, // ✅ إضافة هذا
    this.patientName,
    this.patientAge,
    this.patientGender,
    this.patientCity,
    this.patientEmail,
    this.patientPassword,
    this.patientMarried,
    this.patientPhone,
    this.patientImage,
    this.patientHeight,
    this.patientWeight,
    this.patientBloodType,
    this.patientChronicDiseases,
    this.patientAllergies,
    this.patientMedications,
    this.patientVaccinations,
    this.patientSurgeries,
    this.patientFamilyHistory,
  });

  // Method to combine with medical info
  Patient copyWithMedicalInfo({
    int? patientId,
    double? patientHeight,
    double? patientWeight,
    String? patientBloodType,
    List<String>? patientChronicDiseases,
    List<String>? patientAllergies,
    List<String>? patientMedications,
    List<String>? patientVaccinations,
    List<Map<String, dynamic>>? patientSurgeries,
    List<Map<String, dynamic>>? patientFamilyHistory,
  }) {
    return Patient(
      patientId: patientId ?? this.patientId,
      patientName: this.patientName,
      patientAge: this.patientAge,
      patientGender: this.patientGender,
      patientCity: this.patientCity,
      patientEmail: this.patientEmail,
      patientPassword: this.patientPassword,
      patientMarried: this.patientMarried,
      patientPhone: this.patientPhone,
      patientImage: this.patientImage,
      patientHeight: patientHeight ?? this.patientHeight,
      patientWeight: patientWeight ?? this.patientWeight,
      patientBloodType: patientBloodType ?? this.patientBloodType,
      patientChronicDiseases:
          patientChronicDiseases ?? this.patientChronicDiseases,
      patientAllergies: patientAllergies ?? this.patientAllergies,
      patientMedications: patientMedications ?? this.patientMedications,
      patientVaccinations: patientVaccinations ?? this.patientVaccinations,
      patientSurgeries: patientSurgeries ?? this.patientSurgeries,
      patientFamilyHistory: patientFamilyHistory ?? this.patientFamilyHistory,
    );
  }

  // Convert to JSON for API (Signup)
  Map<String, dynamic> toSignupJson() {
    return {
      'patient_name': patientName,
      'patient_age': patientAge,
      'patient_gender': patientGender,
      'patient_city': patientCity,
      'patient_email': patientEmail,
      'patient_password': patientPassword,
      'patient_married': patientMarried,
      'patient_phone': patientPhone,
      'patient_image': patientImage,
    };
  }

  factory Patient.fromJsonProfile(Map<String, dynamic> json) {
    print("🟢 Parsing profile JSON: $json");

    return Patient(
      patientId: json['patientId'],
      patientName: json['patientName'] ?? 'Unknown',
      patientAge: json['patientAge'] ?? 0,
      // لو null، استخدم 0
      patientGender: json['patientGender'] ?? 'Not specified',
      // لو null، استخدم قيمة افتراضية
      patientCity: json['patientCity'] ?? '',
      patientEmail: json['patientEmail'] ?? '',
      patientMarried: json['patientMarried'] ?? false,
      patientPhone: json['patientPhone'] ?? '',
      patientImage: json['patientImage'],

      // Medical info (افتراضي null)
      patientHeight: json['patientHeight'],
      patientWeight: json['patientWeight'],
      patientBloodType: json['patientBloodType'],
      patientChronicDiseases: json['patientChronicDiseases'] != null
          ? List<String>.from(json['patientChronicDiseases'])
          : null,
      patientAllergies: json['patientAllergies'] != null
          ? List<String>.from(json['patientAllergies'])
          : null,
      patientMedications: json['patientMedications'] != null
          ? List<String>.from(json['patientMedications'])
          : null,
      patientVaccinations: json['patientVaccinations'] != null
          ? List<String>.from(json['patientVaccinations'])
          : null,
      patientSurgeries: json['patientSurgeries'] != null
          ? List<Map<String, dynamic>>.from(json['patientSurgeries'])
          : null,
      patientFamilyHistory: json['patientFamilyHistory'] != null
          ? List<Map<String, dynamic>>.from(json['patientFamilyHistory'])
          : null,
    );
  }
}

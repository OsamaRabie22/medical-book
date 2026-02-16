class Patient {
  final int? patientId;
  final String? patientName;
  final int? patientAge; // للاستخدام الداخلي فقط (مش بيتبعث)
  final String? patientGender;
  final String? patientCity;
  final String? patientEmail;
  final String? patientPassword;
  final bool? patientMarried;
  final String? patientPhone;
  final String? patientImage;
  final String? birthDate; // ✅ أضفناها هنا للتاريخ

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
    this.patientId,
    this.patientName,
    this.patientAge,
    this.patientGender,
    this.patientCity,
    this.patientEmail,
    this.patientPassword,
    this.patientMarried,
    this.patientPhone,
    this.patientImage,
    this.birthDate, // ✅ أضفناها هنا
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
      birthDate: this.birthDate,
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

  // ✅ دالة تحويل البيانات لـ API Signup (الشكل النهائي المطلوب)
  // في lib/models/patient_model.dart
  Map<String, dynamic> toSignupJson() {
    final data = {
      'patient_name': patientName,
      'patient_email': patientEmail,
      'patient_password': patientPassword,
      'patient_phone': patientPhone,
      'patient_city': patientCity,
      'birth_date': birthDate, // تأكد أن هذا موجود
      'patient_gender': patientGender,
      'patient_married': patientMarried,
    };

    // إزالة أي قيم null
    data.removeWhere((key, value) => value == null);

    print("📦 Final signup data: $data");
    return data;
  }

  // ✅ دالة مساعدة لتاريخ افتراضي (لو مفيش تاريخ)
  String _getDefaultBirthDate() {
    return DateTime.now()
        .subtract(const Duration(days: 365 * 25))
        .toIso8601String();
  }

  // ✅ دالة تحويل بيانات البروفايل من API
  // [file name]: lib/models/patient_model.dart

// ✅ دالة تحويل بيانات البروفايل من API - محدثة
  // ✅ دالة تحويل بيانات البروفايل من API - الشكل النهائي
  factory Patient.fromJsonProfile(Map<String, dynamic> json) {
    print("🟢 Parsing profile JSON: $json");
    print("🟢 JSON keys: ${json.keys.toList()}");

    return Patient(
      // ✅ استخدم الأسماء من الـ Response الفعلي
      patientId: json['patient_id'],
      // المفتاح الصحيح
      patientName: json['patient_name'] ?? 'Unknown',
      patientAge: json['patient_age'] ?? 0,
      patientGender: json['patient_Gender'],
      // المفتاح الصحيح
      patientCity: json['patient_city'] ?? '',
      patientEmail: json['patient_email'] ?? '',
      patientMarried: json['patient_married'] ?? false,
      patientPhone: json['patient_phone'] ?? '',
      patientImage: json['patient_image'],
      birthDate: json['birth_date'],

      // Medical info (كلها null حالياً)
      patientHeight: null,
      patientWeight: null,
      patientBloodType: null,
      patientChronicDiseases: null,
      patientAllergies: null,
      patientMedications: null,
      patientVaccinations: null,
      patientSurgeries: null,
      patientFamilyHistory: null,
    );
  }
}

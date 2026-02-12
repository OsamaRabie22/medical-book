class Patient {
  int? patientId;
  String patientName;
  int patientAge;
  String patientGender; // M, F
  String patientCity;
  String patientEmail;
  String patientPassword;
  bool patientMarried;
  String patientPhone;
  String? patientImage; // base64 string

  Patient({
    this.patientId,
    required this.patientName,
    required this.patientAge,
    required this.patientGender,
    required this.patientCity,
    required this.patientEmail,
    required this.patientPassword,
    required this.patientMarried,
    required this.patientPhone,
    this.patientImage,
  });

  // من JSON إلى Object
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      patientId: json['patient_id'],
      patientName: json['patient_name'],
      patientAge: json['patient_age'],
      patientGender: json['patient_gender'],
      patientCity: json['patient_city'],
      patientEmail: json['patient_email'],
      patientPassword: json['patient_password'],
      patientMarried: json['patient_married'] == 1 ? true : false,
      patientPhone: json['patient_phone'],
      patientImage: json['patient_imge'],
    );
  }

  // من Object إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'patient_name': patientName,
      'patient_age': patientAge,
      'patient_gender': patientGender,
      'patient_city': patientCity,
      'patient_email': patientEmail,
      'patient_password': patientPassword,
      'patient_married': patientMarried ? 1 : 0,
      'patient_phone': patientPhone,
      'patient_imge': patientImage,
    };
  }

  // للـ Signup (بدون ID)
  Map<String, dynamic> toSignupJson() {
    return {
      'patient_name': patientName,
      'patient_age': patientAge,
      'patient_gender': patientGender,
      'patient_city': patientCity,
      'patient_email': patientEmail,
      'patient_password': patientPassword,
      'patient_married': patientMarried ? 1 : 0,
      'patient_phone': patientPhone,
      'patient_imge': patientImage,
    };
  }

  // للـ Login
  Map<String, dynamic> toLoginJson() {
    return {
      'patient_email': patientEmail,
      'patient_password': patientPassword,
    };
  }
}
class SickRecord {
  int? sickRecordId;
  int patientHeight; // pationt_Hight
  int patientWeight; // pationt_weight
  bool patientAnaemia;
  bool patientHypertension;
  bool patientDiabetes;
  bool residenceType; // true = Urban, false = Rural
  String patientBloodType;
  int patientId;
  int? doctorId;
  int? diseaseId;
  int? appointmentId;
  String? notes;

  SickRecord({
    this.sickRecordId,
    required this.patientHeight,
    required this.patientWeight,
    required this.patientAnaemia,
    required this.patientHypertension,
    required this.patientDiabetes,
    required this.residenceType,
    required this.patientBloodType,
    required this.patientId,
    this.doctorId,
    this.diseaseId,
    this.appointmentId,
    this.notes,
  });

  // من JSON إلى Object
  factory SickRecord.fromJson(Map<String, dynamic> json) {
    return SickRecord(
      sickRecordId: json['Sick_record_id'],
      patientHeight: json['pationt_Hight'],
      patientWeight: json['pationt_weight'],
      patientAnaemia: json['patient_anaemia'] == 1 ? true : false,
      patientHypertension: json['patient_hypertension'] == 1 ? true : false,
      patientDiabetes: json['patient_diabetes'] == 1 ? true : false,
      residenceType: json['Residence_type'] == 1 ? true : false,
      patientBloodType: json['patient_bloodtype'],
      patientId: json['patient_id'],
      doctorId: json['doctor_id'],
      diseaseId: json['disease_id'],
      appointmentId: json['appointment_id'],
      notes: json['notes'],
    );
  }

  // من Object إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'Sick_record_id': sickRecordId,
      'pationt_Hight': patientHeight,
      'pationt_weight': patientWeight,
      'patient_anaemia': patientAnaemia ? 1 : 0,
      'patient_hypertension': patientHypertension ? 1 : 0,
      'patient_diabetes': patientDiabetes ? 1 : 0,
      'Residence_type': residenceType ? 1 : 0,
      'patient_bloodtype': patientBloodType,
      'patient_id': patientId,
      'doctor_id': doctorId,
      'disease_id': diseaseId,
      'appointment_id': appointmentId,
      'notes': notes,
    };
  }

  // للـ Create (بدون ID)
  Map<String, dynamic> toCreateJson() {
    return {
      'pationt_Hight': patientHeight,
      'pationt_weight': patientWeight,
      'patient_anaemia': patientAnaemia ? 1 : 0,
      'patient_hypertension': patientHypertension ? 1 : 0,
      'patient_diabetes': patientDiabetes ? 1 : 0,
      'Residence_type': residenceType ? 1 : 0,
      'patient_bloodtype': patientBloodType,
      'patient_id': patientId,
      'doctor_id': doctorId,
      'disease_id': diseaseId,
      'appointment_id': appointmentId,
      'notes': notes,
    };
  }
}
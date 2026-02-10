import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/doctor_model.dart';
import '../data/dummy_data.dart';

class DoctorsProvider extends ChangeNotifier {
  List<Doctor> _doctors = [...dummyDoctors];

  // Getter للقائمة الأصلية
  List<Doctor> get allDoctors => List.from(_doctors);

  // Getter للأطباء المحفوظين فقط
  List<Doctor> get savedDoctors =>
      _doctors.where((doctor) => doctor.isSaved).toList();

  // Getter للأطباء غير المحفوظين
  List<Doctor> get unsavedDoctors =>
      _doctors.where((doctor) => !doctor.isSaved).toList();

  // البحث عن طبيب بالاسم
  Doctor? getDoctorById(String name) {
    try {
      return _doctors.firstWhere((doctor) => doctor.name == name);
    } catch (e) {
      return null;
    }
  }

  // تغيير حالة الحفظ لطبيب
  void toggleSaveDoctor(String doctorName) {
    final index = _doctors.indexWhere((doctor) => doctor.name == doctorName);

    if (index != -1) {
      _doctors[index] = _doctors[index].copyWith(
          isSaved: !_doctors[index].isSaved
      );
      notifyListeners();
    }
  }

  // التحقق إذا كان الطبيب محفوظاً
  bool isDoctorSaved(String doctorName) {
    final doctor = getDoctorById(doctorName);
    return doctor?.isSaved ?? false;
  }

  // تحديث تقييم الطبيب
  void updateDoctorRating(String doctorName, double newRating) {
    final index = _doctors.indexWhere((doctor) => doctor.name == doctorName);

    if (index != -1) {
      _doctors[index] = _doctors[index].copyWith(
          rating: newRating
      );
      notifyListeners();
    }
  }
}
import 'package:flutter/foundation.dart';
import '../models/doctor_model.dart';
import '../data/dummy_data.dart';

class DoctorsProvider extends ChangeNotifier {
  List<Doctor> _doctors = [...dummyDoctors];
  List<Doctor> _filteredDoctors = [...dummyDoctors];

  // Getter للقائمة الأصلية
  List<Doctor> get allDoctors => List.from(_doctors);

  // Getter للقائمة المفلترة
  List<Doctor> get filteredDoctors => List.from(_filteredDoctors);

  // Getter للأطباء المحفوظين فقط
  List<Doctor> get savedDoctors =>
      _doctors.where((doctor) => doctor.isSaved).toList();

  // البحث عن أطباء - تحسين الدالة للبحث بدون Dr.
  void searchDoctors(String query) {
    if (query.isEmpty) {
      _filteredDoctors = List.from(_doctors);
    } else {
      // تحويل النص للبحث إلى حروف صغيرة للتجاهل حالة الأحرف
      final lowercaseQuery = query.toLowerCase().trim();

      _filteredDoctors = _doctors.where((doctor) {
        // البحث في الاسم
        final doctorName = doctor.name.toLowerCase();

        // البحث في التخصص
        final specialty = doctor.specialty.toLowerCase();

        // البحث في المكان
        final location = doctor.location.toLowerCase();

        // البحث في الاسم أو التخصص أو المكان
        return doctorName.contains(lowercaseQuery) ||
            specialty.contains(lowercaseQuery) ||
            location.contains(lowercaseQuery) ||
            // البحث بالأسماء الأولى فقط
            doctorName.split(' ').first.contains(lowercaseQuery) ||
            doctorName.split(' ').last.contains(lowercaseQuery);
      }).toList();
    }
    notifyListeners();
  }

  // تصفية الأطباء حسب التخصص
  List<Doctor> getDoctorsBySpecialty(String specialty) {
    return _doctors.where((doctor) {
      return doctor.specialty.toLowerCase() == specialty.toLowerCase() ||
          doctor.specialty.toLowerCase().contains(specialty.toLowerCase());
    }).toList();
  }

  // الحصول على التخصصات المميزة
  List<String> getFeaturedSpecialties() {
    final allSpecialties = _doctors.map((doctor) => doctor.specialty).toSet();
    return allSpecialties.toList();
  }

  // البحث عن طبيب بالاسم
  Doctor? getDoctorByName(String name) {
    try {
      return _doctors.firstWhere((doctor) =>
      doctor.name.toLowerCase() == name.toLowerCase());
    } catch (e) {
      return null;
    }
  }

  // تغيير حالة الحفظ لطبيب
  void toggleSaveDoctor(String doctorName) {
    final index = _doctors.indexWhere((doctor) =>
    doctor.name.toLowerCase() == doctorName.toLowerCase());

    if (index != -1) {
      // إنشاء نسخة جديدة من الطبيب مع تغيير حالة الحفظ
      _doctors[index] = Doctor(
        name: _doctors[index].name,
        specialty: _doctors[index].specialty,
        location: _doctors[index].location,
        contact: _doctors[index].contact,
        rating: _doctors[index].rating,
        image: _doctors[index].image,
        availableTimes: _doctors[index].availableTimes,
        consultationFee: _doctors[index].consultationFee,
        isSaved: !_doctors[index].isSaved,
      );
      notifyListeners();
    }
  }

  // التحقق إذا كان الطبيب محفوظاً
  bool isDoctorSaved(String doctorName) {
    final doctor = getDoctorByName(doctorName);
    return doctor?.isSaved ?? false;
  }
}
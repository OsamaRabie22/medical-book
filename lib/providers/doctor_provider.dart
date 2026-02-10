import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/doctor_model.dart';

class DoctorProvider extends ChangeNotifier {
  // قائمة الأطباء المحفوظين
  List<Doctor> _doctors = dummyDoctors;

  List<Doctor> get doctors => _doctors;

  // لتحديث حالة "isSaved" للطبيب
  void toggleSaveDoctor(Doctor doctor) {
    doctor.isSaved = !doctor.isSaved;
    notifyListeners();  // إعلام الواجهة بالتغيير
  }

  // لحفظ الأطباء المحفوظين فقط
  List<Doctor> get savedDoctors {
    return _doctors.where((doctor) => doctor.isSaved).toList();
  }
}

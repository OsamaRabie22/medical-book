import 'package:flutter/material.dart';
import '../models/doctor_model.dart';

class AppointmentState extends ChangeNotifier {
  List<Doctor> _doctors = []; // قائمة الأطباء

  // الحصول على الأطباء المحفوظين
  List<Doctor> get savedDoctors {
    return _doctors.where((doctor) => doctor.isSaved).toList();
  }

  // إضافة دكتور جديد
  void addDoctor(Doctor doctor) {
    _doctors.add(doctor);
    notifyListeners();
  }

  // تغيير حالة الحفظ
  void toggleSaveDoctor(Doctor doctor) {
    doctor.isSaved = !doctor.isSaved;
    notifyListeners();  // تحديث الواجهة بعد التغيير
  }

  // إضافة الحجز الجديد
  List<Booking> _appointments = [];

  List<Booking> get appointments => _appointments;

  void addAppointment(Booking appointment) {
    _appointments.add(appointment);
    notifyListeners();
  }

  // الحصول على الحجوزات المكتملة
  List<Booking> getCompletedAppointments() {
    return _appointments.where((appointment) => appointment.status == 'Completed').toList();
  }

  // الحصول على الحجوزات الملغاة
  List<Booking> getCancelledAppointments() {
    return _appointments.where((appointment) => appointment.status == 'Cancelled').toList();
  }
}

// doctor_model.dart
// doctor_model.dart
// doctor_model.dart
import 'dart:ui';

// doctor_model.dart
class Doctor {
  String name;
  String specialty;
  String location;
  String contact;
  double rating;
  String image;
  List<String> availableTimes;
  double consultationFee;
  bool isSaved;  // إضافة الحقل هنا

  Doctor({
    required this.name,
    required this.specialty,
    required this.location,
    required this.contact,
    required this.rating,
    required this.image,
    required this.availableTimes,
    required this.consultationFee,
    this.isSaved = false,  // تعيين القيمة الافتراضية
  });
}




// booking_model.dart


class Booking {
  String doctorName;
  String specialty;
  String doctorImage;
  String status; // الحالة مثل "Completed", "Cancelled"
  Color statusColor; // اللون المرتبط بالحالة
  Color statusBackground; // الخلفية الملونة بناءً على الحالة
  String date;
  String time;
  String location;
  double consultationFee;
  bool isSaved; // إذا كانت الحجز محفوظة أم لا
  double rating;

  Booking({
    required this.doctorName,
    required this.specialty,
    required this.doctorImage,
    required this.status,
    required this.statusColor,
    required this.statusBackground,
    required this.date,
    required this.time,
    required this.location,
    required this.consultationFee,
    this.isSaved = false,
    required this.rating,
  });
}

// payment_confirmation_model.dart
class PaymentConfirmation {
  Booking booking;
  String status;  // تأكيد الدفع (مثل "Confirmed", "Pending")

  PaymentConfirmation({
    required this.booking,
    required this.status,
  });
}



// doctor_model.dart
// doctor_model.dart
// doctor_model.dart
import 'dart:ui';

import '../core/constants/app_colors.dart';

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
  bool isSaved;

  Doctor({
    required this.name,
    required this.specialty,
    required this.location,
    required this.contact,
    required this.rating,
    required this.image,
    required this.availableTimes,
    required this.consultationFee,
    this.isSaved = false,
  });

  // إضافة دالة copyWith
  Doctor copyWith({
    String? name,
    String? specialty,
    String? location,
    String? contact,
    double? rating,
    String? image,
    List<String>? availableTimes,
    double? consultationFee,
    bool? isSaved,
  }) {
    return Doctor(
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      location: location ?? this.location,
      contact: contact ?? this.contact,
      rating: rating ?? this.rating,
      image: image ?? this.image,
      availableTimes: availableTimes ?? this.availableTimes,
      consultationFee: consultationFee ?? this.consultationFee,
      isSaved: isSaved ?? this.isSaved,
    );
  }
  String get nameWithoutTitle {
    return name.replaceAll(RegExp(r'^Dr\.\s*', caseSensitive: false), '');
  }

  // إضافة دالة للبحث في جميع الحقول
  bool matchesSearch(String query) {
    final lowerQuery = query.toLowerCase();
    return name.toLowerCase().contains(lowerQuery) ||
        nameWithoutTitle.toLowerCase().contains(lowerQuery) ||
        specialty.toLowerCase().contains(lowerQuery) ||
        location.toLowerCase().contains(lowerQuery);
  }
}




// booking_model.dart


// booking_model.dart

class Booking {
  String doctorName;
  String specialty;
  String doctorImage;
  String status; // الحالة مثل "Completed", "Cancelled", "Upcoming"
  Color statusColor;
  Color statusBackground;
  String date;
  String time;
  String location;
  double consultationFee;
  bool isSaved;
  double rating;

  // حقول جديدة للتشخيص
  String? diagnosis; // التشخيص
  List<String>? previousDiagnoses; // للتشخيصات السابقة (لو رحت للدكتور مرتين)

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
    this.diagnosis,
    this.previousDiagnoses,
  });

  // دالة مساعدة للحصول على الألوان حسب الحالة
  static Color getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return AppColors.success;
      case 'Cancelled':
        return AppColors.error;
      case 'Upcoming':
        return AppColors.primary;
      default:
        return AppColors.grey;
    }
  }

  static Color getStatusBackground(String status) {
    switch (status) {
      case 'Completed':
        return AppColors.success.withOpacity(0.1);
      case 'Cancelled':
        return AppColors.error.withOpacity(0.1);
      case 'Upcoming':
        return AppColors.primary.withOpacity(0.1);
      default:
        return AppColors.grey.withOpacity(0.1);
    }
  }
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



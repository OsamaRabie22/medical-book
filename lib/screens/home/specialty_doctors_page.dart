import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../models/doctor_model.dart';
import 'booking_page.dart';
import '../../widgets/doctor_card.dart';
import '../../data/dummy_data.dart'; // تأكد من إضافة هذا الـ import

class SpecialtyDoctorsPage extends StatefulWidget {
  final String specialty;

  const SpecialtyDoctorsPage({
    super.key,
    required this.specialty,
  });

  @override
  State<SpecialtyDoctorsPage> createState() => _SpecialtyDoctorsPageState();
}

class _SpecialtyDoctorsPageState extends State<SpecialtyDoctorsPage> {
  List<Doctor> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    _filterDoctorsBySpecialty();
  }

  void _filterDoctorsBySpecialty() {
    setState(() {
      filteredDoctors = dummyDoctors.where((doctor) {
        return doctor.specialty.toLowerCase().contains(
          widget.specialty.toLowerCase(),
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          widget.specialty,
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primaryDark,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16 * scale),
            child: Row(
              children: [
                Text(
                  "${filteredDoctors.length} Doctors found",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredDoctors.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.medical_services,
                    size: 60 * scale,
                    color: AppColors.grey,
                  ),
                  SizedBox(height: 16 * scale),
                  Text(
                    "No doctors found",
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(height: 8 * scale),
                  Text(
                    "Try a different specialty",
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.all(16 * scale),
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 12 * scale),
                  child: DoctorCard(
                    doctor: doctor, // تم التعديل هنا لاستخدام الموديل
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingPage(
                            doctorName: doctor.name,
                            specialty: doctor.specialty,
                            doctorImage: doctor.image,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

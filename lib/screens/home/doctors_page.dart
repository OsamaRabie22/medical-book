import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../models/doctor_model.dart';
import 'booking_page.dart';
import 'doctor_card.dart';
import '../../data/dummy_data.dart'; // تأكد من إضافة هذا الـ import

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  TextEditingController searchController = TextEditingController();
  List<Doctor> doctors = dummyDoctors; // استخدمنا الـ dummyDoctors هنا

  List<Doctor> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    filteredDoctors = List.from(doctors);
  }

  void filterDoctors(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredDoctors = List.from(doctors);
      } else {
        filteredDoctors = doctors.where((doctor) {
          final name = doctor.name.toLowerCase();
          final specialty = doctor.specialty.toLowerCase();
          final searchLower = query.toLowerCase();
          return name.contains(searchLower) || specialty.contains(searchLower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "Doctors",
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
          // Search Bar
          Padding(
            padding: EdgeInsets.all(16 * scale),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(18 * scale),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6 * scale,
                    offset: Offset(0, 2 * scale),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: filterDoctors,
                decoration: InputDecoration(
                  hintText: "Search for a doctor or specialty",
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: AppColors.primary,
                    size: isTablet ? 26 * scale : 22 * scale,
                  ),
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.grey,
                    fontSize: isTablet ? 16 * scale : 14 * scale,
                  ),
                ),
              ),
            ),
          ),

          // نتائج البحث
          Expanded(
            child: filteredDoctors.isEmpty
                ? Center(
              child: Text(
                "No doctors found",
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.grey,
                ),
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 12 * scale),
                  child: DoctorCard(
                    doctor: doctor, // هنا تم التعديل لاستقبال Doctor
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


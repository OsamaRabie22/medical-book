import 'package:flutter/material.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../data/dummy_data.dart';
import '../../widgets/app_logo.dart';
import 'booking_page.dart';
import 'doctor_card.dart';
import 'header.dart';
import 'home_page.dart';
import 'top_doctors_section.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  void _navigateToSearchPage(BuildContext context) {
    // إستبدل الشاشة الحالية بـ HomePage مع index 1 (Search)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(initialIndex: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 24 * scale : 20 * scale,
          vertical: isTablet ? 12 * scale : 8 * scale,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ اللوجو
            const Center(child: AppLogo()),

            // ✅ Header
            buildHeader(context),
            SizedBox(height: isTablet ? 25 * scale : 20 * scale),

            // ✅ Top Doctors Section
            TopDoctorsSection(),
            SizedBox(height: isTablet ? 30 * scale : 25 * scale),

            // ✅ Search Bar و All Doctors معاً في خلفية بيضاء واحدة
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isTablet ? 20 * scale : 16 * scale),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20 * scale),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8 * scale,
                    offset: Offset(0, 2 * scale),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  GestureDetector(
                    onTap: () => _navigateToSearchPage(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                      decoration: BoxDecoration(
                        color: AppColors.scaffoldBackground,
                        borderRadius: BorderRadius.circular(15 * scale),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: AppColors.primary,
                            size: isTablet ? 26 * scale : 22 * scale,
                          ),
                          SizedBox(width: 12 * scale),
                          Expanded(
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: "Search for doctors, specialties...",
                                border: InputBorder.none,
                                hintStyle: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.grey,
                                  fontSize: isTablet ? 16 * scale : 14 * scale,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: isTablet ? 25 * scale : 20 * scale),

                  // عنوان الـ All Doctors
                  Text(
                    "All Doctors",
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: AppColors.primaryDark,
                      fontSize: isTablet ? 24 * scale : 22 * scale,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: isTablet ? 20 * scale : 16 * scale),

                  // ✅ Doctor Cards
                  ...dummyDoctors.map((doctor) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: isTablet ? 16 * scale : 14 * scale),
                      child: DoctorCard(
                        doctor: doctor,  // تمرير الـ Doctor بدلاً من الـ Map
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
                  }).toList(),
                ],
              ),
            ),

            SizedBox(height: isTablet ? 30 * scale : 25 * scale),
          ],
        ),
      ),
    );
  }
}

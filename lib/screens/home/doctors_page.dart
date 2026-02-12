import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';
import 'booking_page.dart';
import 'doctor_card.dart';
import '../../states/appointment_state.dart'; // للوصول إلى DoctorsProvider

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // عند فتح الصفحة، امسح أي بحث سابق
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DoctorsProvider>(context, listen: false);
      provider.searchDoctors('');
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DoctorsProvider>(context);
    final filteredDoctors = provider.filteredDoctors;
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
          // Search Bar باستخدام Provider
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
                onChanged: (value) {
                  provider.searchDoctors(value);
                },
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
            child: searchController.text.isNotEmpty && filteredDoctors.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
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
                    "Try a different search term",
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
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
                    doctor: doctor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingPage(
                            doctorName: doctor.name,
                            specialty: doctor.specialty,
                            doctorImage: doctor.image,
                            rating: doctor.rating,
                            location: doctor.location,
                            consultationFee: doctor.consultationFee,
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
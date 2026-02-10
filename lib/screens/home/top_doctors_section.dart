import 'package:flutter/material.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../data/dummy_data.dart';
import '../../models/doctor_model.dart';
import 'booking_page.dart';
import 'home_page.dart';

class TopDoctorsSection extends StatelessWidget {
  TopDoctorsSection({super.key});

  // استخدام قائمة الأطباء التي تحتوي على 20 دكتورًا
  final List<Doctor> doctors = dummyDoctors;

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

    // ترتيب الأطباء حسب التقييم وتصفية أفضل 5 فقط
    final topDoctors = doctors..sort((a, b) => b.rating.compareTo(a.rating));
    final top5Doctors = topDoctors.take(5).toList();

    return Container(
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
          // العنوان و See All
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Top Doctors",
                style: AppTextStyles.headlineSmall.copyWith(
                  color: AppColors.primaryDark,
                  fontSize: isTablet ? 24 * scale : 22 * scale,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // في جزء الـ See All
              TextButton(
                onPressed: () => _navigateToSearchPage(context),
                child: Text(
                  "See All",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontSize: isTablet ? 16 * scale : 14 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),

          SizedBox(height: isTablet ? 20 * scale : 16 * scale),

          // قائمة الأطباء
          SizedBox(
            height: isTablet ? 220 * scale : 200 * scale,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: top5Doctors.length,  // عرض أفضل 5 دكاترة فقط
              itemBuilder: (context, index) {
                final doctor = top5Doctors[index];
                return GestureDetector(
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
                  child: Container(
                    width: isTablet ? 160 * scale : 140 * scale,
                    margin: EdgeInsets.only(right: 16 * scale),
                    decoration: BoxDecoration(
                      color: AppColors.scaffoldBackground,
                      borderRadius: BorderRadius.circular(16 * scale),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 6 * scale,
                          offset: Offset(0, 2 * scale),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // الصورة مع التقيم
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16 * scale),
                                topRight: Radius.circular(16 * scale),
                              ),
                              child: Image.asset(
                                doctor.image,
                                width: double.infinity,
                                height: isTablet ? 120 * scale : 110 * scale,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8 * scale,
                              right: 8 * scale,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8 * scale,
                                  vertical: 4 * scale,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.9),
                                  borderRadius:
                                  BorderRadius.circular(12 * scale),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: isTablet ? 16 * scale : 14 * scale,
                                    ),
                                    SizedBox(width: 3 * scale),
                                    Text(
                                      doctor.rating.toString(),
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize:
                                        isTablet ? 14 * scale : 12 * scale,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // المعلومات
                        Padding(
                          padding: EdgeInsets.all(12 * scale),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.name,
                                style: AppTextStyles.bodyLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isTablet ? 16 * scale : 14 * scale,
                                  color: AppColors.primaryDark,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4 * scale),
                              Text(
                                doctor.specialty,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.greyDark,
                                  fontSize: isTablet ? 14 * scale : 12 * scale,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 6 * scale),
                              // المكان مع الأيقونة
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.red.shade400,
                                    size: isTablet ? 16 * scale : 14 * scale,
                                  ),
                                  SizedBox(width: 4 * scale),
                                  Expanded(
                                    child: Text(
                                      doctor.location,
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.grey,
                                        fontSize:
                                        isTablet ? 12 * scale : 11 * scale,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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


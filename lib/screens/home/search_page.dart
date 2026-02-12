import 'package:flutter/material.dart';
import 'package:medical_book/screens/home/search_results_page.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "Specialties",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
            color: AppColors.primaryDark,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primaryDark,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: isTablet ? 24 * scale : 20 * scale,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          children: [
            // أشهر 12 تخصص - بيملوا الصفحة
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 12 * scale,
                crossAxisSpacing: 12 * scale,
                childAspectRatio: 0.9,
                children: [
                  _buildSpecialtyCard(
                    context,
                    "Internal Medicine",
                    "الباطنة",
                    "assets/icons/Internal_Medicine.png",
                    scale,
                  ),
                  _buildSpecialtyCard(
                    context,
                    "Pediatrics",
                    "الأطفال",
                    "assets/icons/Pediatrics.png",
                    scale,
                  ),
                  _buildSpecialtyCard(
                    context,
                    "Gynecology",
                    "نساء وتوليد",
                    "assets/icons/Obstetrics_Gynecology.png",
                    scale,
                  ),
                  _buildSpecialtyCard(
                    context,
                    "ENT",
                    "أنف وأذن",
                    "assets/icons/ENT.png",
                    scale,
                  ),
                  _buildSpecialtyCard(
                    context,
                    "Dermatology",
                    "جلدية",
                    "assets/icons/Dermatology.png",
                    scale,
                  ),
                  _buildSpecialtyCard(
                    context,
                    "Ophthalmology",
                    "عيون",
                    "assets/icons/Ophthalmology.png",
                    scale,
                  ),
                  _buildSpecialtyCard(
                    context,
                    "Dentistry",
                    "أسنان",
                    "assets/icons/Dentistry.png",
                    scale,
                  ),
                  _buildSpecialtyCard(
                    context,
                    "Orthopedics",
                    "عظام",
                    "assets/icons/Orthopedics.png",
                    scale,
                  ),
                  _buildSpecialtyCard(
                    context,
                    "Cardiology",
                    "قلب",
                    "assets/icons/Cardiology.png",
                    scale,
                  ),
                  _buildSpecialtyCard(
                    context,
                    "Neurology",
                    "مخ وأعصاب",
                    "assets/icons/Neurology.png",
                    scale,
                  ),
                  _buildSpecialtyCard(
                    context,
                    "Psychiatry",
                    "نفسي",
                    "assets/icons/Psychiatry.png",
                    scale,
                  ),
                  _buildSpecialtyCard(
                    context,
                    "Urology",
                    "مسالك بولية",
                    "assets/icons/Urology.png",
                    scale,
                  ),
                ],
              ),
            ),

            SizedBox(height: 16 * scale),

            // Other - في الآخر
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("جميع التخصصات"),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16 * scale),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16 * scale),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8 * scale,
                      offset: Offset(0, 2 * scale),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.grid_view_rounded,
                      color: AppColors.primary,
                      size: isTablet ? 24 * scale : 20 * scale,
                    ),
                    SizedBox(width: 8 * scale),
                    Text(
                      "All Specialties",
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: isTablet ? 18 * scale : 16 * scale,
                      ),
                    ),
                    SizedBox(width: 4 * scale),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.primary,
                      size: isTablet ? 18 * scale : 14 * scale,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialtyCard(
      BuildContext context,
      String specialty,
      String arabicName,
      String imagePath,
      double scale,
      ) {
    final isTablet = ResponsiveUtils.isTablet(context);

    return GestureDetector(
      onTap: () => _navigateToSearchResults(context, specialty),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20 * scale),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10 * scale,
              offset: Offset(0, 4 * scale),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // صورة بدل الأيقونة
            Container(
              width: 52 * scale,
              height: 52 * scale,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  width: 52 * scale,
                  height: 52 * scale,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 12 * scale),
            // الاسم بالإنجليزي - كبير وواضح
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6 * scale),
              child: Text(
                specialty.split(' ').take(2).join(' '),
                style: TextStyle(
                  fontSize: isTablet ? 14 * scale : 12 * scale,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryDark,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 4 * scale),
            // الاسم بالعربي - صغير ورمادي
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6 * scale),
              child: Text(
                arabicName,
                style: TextStyle(
                  fontSize: isTablet ? 11 * scale : 9 * scale,
                  color: AppColors.grey,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSearchResults(BuildContext context, String query) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsPage(
          initialQuery: query,
        ),
      ),
    );
  }
}
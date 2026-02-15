import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../providers/patient_provider.dart';

Widget buildHeader(BuildContext context) {
  final scale = ResponsiveUtils.getScale(context);
  final isTablet = ResponsiveUtils.isTablet(context);
  final patientProvider = Provider.of<PatientProvider>(context);
  final patient = patientProvider.currentPatient;

  // اسم المستخدم من PatientProvider أو قيمة افتراضية
  String displayName = patient?.patientName ?? "Guest";

  // أول حرف من الاسم للصورة
  String firstLetter = displayName.isNotEmpty ? displayName[0].toUpperCase() : "?";

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
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // Profile Image بنفس تصميم الـ Profile
            Container(
              width: isTablet ? 64 * scale : 52 * scale,
              height: isTablet ? 64 * scale : 52 * scale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  firstLetter,
                  style: TextStyle(
                    fontSize: isTablet ? 28 * scale : 22 * scale,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: isTablet ? 18 * scale : 14 * scale),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, $displayName 👋",
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: AppColors.black,
                    fontSize: isTablet ? 20 * scale : 18 * scale,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "How are you feeling today?",
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.grey,
                    fontSize: isTablet ? 16 * scale : 14 * scale,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
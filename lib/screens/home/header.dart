import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';

import 'package:shared_preferences/shared_preferences.dart';

// هذه الدالة تسترجع اسم المستخدم
Future<String?> _getUserName() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_name'); // استرجاع اسم المستخدم
}

Widget buildHeader(BuildContext context) {
  final scale = ResponsiveUtils.getScale(context);
  final isTablet = ResponsiveUtils.isTablet(context);

  return FutureBuilder<String?>(
    future: _getUserName(), // استرجاع اسم المستخدم
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator(); // إذا كان لا يزال في انتظار
      }

      final userName = snapshot.data ?? "Osama"; // إذا كان الاسم فارغ يتم عرض "Osama"

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
                CircleAvatar(
                  radius: isTablet ? 32 * scale : 26 * scale,
                  backgroundImage: const AssetImage(
                    "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
                  ),
                ),
                SizedBox(width: isTablet ? 18 * scale : 14 * scale),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, $userName👋", // عرض اسم المستخدم
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
    },
  );
}

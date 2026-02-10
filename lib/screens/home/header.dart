import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';

Widget buildHeader(BuildContext context) {
  final scale = ResponsiveUtils.getScale(context);
  final isTablet = ResponsiveUtils.isTablet(context);

  return Container(
    width: double.infinity, // علشان ياخد عرض الشاشة كله
    padding: EdgeInsets.all(isTablet ? 20 * scale : 16 * scale),
    decoration: BoxDecoration(
      color: AppColors.white, // الخلفية البيضاء
      borderRadius: BorderRadius.circular(20 * scale), // الـ radius
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
                  "Hello, Osama👋",
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
        // ممكن نضيف أيقونة تانيه هنا لو عاوز في المستقبل
      ],
    ),
  );
}
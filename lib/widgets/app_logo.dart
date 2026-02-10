import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/utils/responsive_utils.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Medical",
            style: TextStyle(
              fontSize: isTablet ? 36 * scale : 32 * scale,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(width: isTablet ? 6 * scale : 5 * scale),
          Text(
            "Book",
            style: TextStyle(
              fontSize: isTablet ? 36 * scale : 32 * scale,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

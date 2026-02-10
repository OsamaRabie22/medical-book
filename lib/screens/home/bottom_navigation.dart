import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../appointment/appointments_page.dart';
import 'search_page.dart'; // إحنا هنستخدم SearchPage بدل DoctorsPage

// DoctorsPage إتستبدلت بـ SearchPage
class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchPage(); // رجعت SearchPage هنا
  }
}

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => AppointmentsPageState();
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          "Profile Page",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
          ),
        ),
      ),
    );
  }
}

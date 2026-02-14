// [اسم الملف: اللي عندك - غالباً home_content.dart أو حاجة شبه كده]

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_book/screens/home/search_page.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../models/patient_model.dart';
import '../../providers/patient_provider.dart';
import '../auth/login_page.dart';
import '../appointment/appointments_page.dart';

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

// ✅ ProfilePage المحدثة
// [file name]: lib/screens/profile/profile_page.dart

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    final patientProvider = Provider.of<PatientProvider>(context);
    final patient = patientProvider.currentPatient;

    // إذا مفيش Patient (مش logged in)
    if (patient == null) {
      return _buildNotLoggedInView(scale);
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
            color: AppColors.primaryDark,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primaryDark,
        actions: [
          // زر الإعدادات (مستقبلاً)
          // IconButton(
          //   icon: Icon(Icons.settings_outlined, size: 24 * scale),
          //   onPressed: () {},
          // ),
        ],
      ),
      body: patientProvider.isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      )
          : SingleChildScrollView(
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          children: [
            // ✅ Profile Header
            _buildProfileHeader(patient, scale),

            SizedBox(height: 24 * scale),

            // ✅ Personal Information Card
            _buildSectionCard(
              title: "Personal Information",
              icon: Icons.person_outline,
              scale: scale,
              children: [
                _buildInfoRow(
                  icon: Icons.cake_outlined,
                  label: "Age",
                  value: patient.patientAge != null && patient.patientAge! > 0
                      ? "${patient.patientAge} years"
                      : "Not specified",
                  scale: scale,
                ),
                _buildInfoRow(
                  icon: patient.patientGender == "male" ? Icons.male : Icons.female,
                  label: "Gender",
                  value: patient.patientGender?.capitalize ?? "Not specified",
                  scale: scale,
                ),
                _buildInfoRow(
                  icon: Icons.favorite_outline,
                  label: "Marital Status",
                  value: patient.patientMarried == true ? "Married" : patient.patientMarried == false ? "Single" : "Not specified",
                  scale: scale,
                ),
              ],
            ),

            SizedBox(height: 16 * scale),

            // ✅ Contact Information Card
            _buildSectionCard(
              title: "Contact Information",
              icon: Icons.contact_phone_outlined,
              scale: scale,
              children: [
                _buildInfoRow(
                  icon: Icons.email_outlined,
                  label: "Email",
                  value: patient.patientEmail ?? "Not provided",
                  scale: scale,
                  isEmail: true,
                ),
                _buildInfoRow(
                  icon: Icons.phone_outlined,
                  label: "Phone",
                  value: patient.patientPhone ?? "Not provided",
                  scale: scale,
                ),
                _buildInfoRow(
                  icon: Icons.location_on_outlined,
                  label: "City",
                  value: patient.patientCity ?? "Not provided",
                  scale: scale,
                ),
              ],
            ),

            SizedBox(height: 16 * scale),

            // ✅ Medical Information Card (إذا كانت موجودة)
            if (patient.patientHeight != null ||
                patient.patientWeight != null ||
                patient.patientBloodType != null)
              _buildSectionCard(
                title: "Medical Information",
                icon: Icons.medical_information_outlined,
                scale: scale,
                children: [
                  if (patient.patientHeight != null)
                    _buildInfoRow(
                      icon: Icons.height,
                      label: "Height",
                      value: "${patient.patientHeight} cm",
                      scale: scale,
                    ),
                  if (patient.patientWeight != null)
                    _buildInfoRow(
                      icon: Icons.monitor_weight_outlined,
                      label: "Weight",
                      value: "${patient.patientWeight} kg",
                      scale: scale,
                    ),
                  if (patient.patientBloodType != null)
                    _buildInfoRow(
                      icon: Icons.bloodtype_outlined,
                      label: "Blood Type",
                      value: patient.patientBloodType!,
                      scale: scale,
                    ),
                ],
              ),

            SizedBox(height: 24 * scale),

            // ✅ Logout Button
            _buildLogoutButton(scale, patientProvider, context),

            SizedBox(height: 20 * scale),
          ],
        ),
      ),
    );
  }

  // ✅ Profile Header مع صورة
  Widget _buildProfileHeader(Patient patient, double scale) {
    return Container(
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15 * scale,
            offset: Offset(0, 5 * scale),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Image
          Container(
            width: 80 * scale,
            height: 80 * scale,
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
                patient.patientName?[0].toUpperCase() ?? "?",
                style: TextStyle(
                  fontSize: 32 * scale,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 20 * scale),
          // Name and ID
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient.patientName ?? "Unknown",
                  style: AppTextStyles.headlineMedium.copyWith(
                    fontSize: 22 * scale,
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  "Patient ID: ${patient.patientId ?? "N/A"}",
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 14 * scale,
                    color: AppColors.grey,
                  ),
                ),
                if (patient.patientEmail != null) ...[
                  SizedBox(height: 4 * scale),
                  Text(
                    patient.patientEmail!,
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 13 * scale,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Card Section Builder
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required double scale,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10 * scale,
            offset: Offset(0, 3 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title with Icon
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8 * scale),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8 * scale),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 18 * scale,
                ),
              ),
              SizedBox(width: 12 * scale),
              Text(
                title,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          ...children,
        ],
      ),
    );
  }

  // ✅ Info Row Builder
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required double scale,
    bool isEmail = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20 * scale,
            color: AppColors.primary,
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 12 * scale,
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  value,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 14 * scale,
                    color: isEmail ? AppColors.primary : AppColors.primaryDark,
                    fontWeight: isEmail ? FontWeight.w500 : FontWeight.normal,
                    decoration: isEmail ? TextDecoration.underline : TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Logout Button
  Widget _buildLogoutButton(double scale, PatientProvider provider, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _showLogoutDialog(context, provider, scale),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.error,
          side: BorderSide(color: AppColors.error.withOpacity(0.3), width: 1.5),
          padding: EdgeInsets.symmetric(vertical: 16 * scale),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14 * scale),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout,
              size: 20 * scale,
              color: AppColors.error,
            ),
            SizedBox(width: 8 * scale),
            Text(
              "Logout",
              style: AppTextStyles.buttonMedium.copyWith(
                fontSize: 16 * scale,
                color: AppColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Not Logged In View
  Widget _buildNotLoggedInView(double scale) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(32 * scale),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(24 * scale),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_outline,
                  size: 60 * scale,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 32 * scale),
              Text(
                "Not Logged In",
                style: AppTextStyles.headlineMedium.copyWith(
                  fontSize: 24 * scale,
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12 * scale),
              Text(
                "Please login to view your profile information",
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 16 * scale,
                  color: AppColors.greyDark,
                ),
              ),
              SizedBox(height: 32 * scale),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => const LoginPage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 16 * scale),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14 * scale),
                    ),
                  ),
                  child: Text(
                    "Go to Login",
                    style: AppTextStyles.buttonMedium.copyWith(
                      fontSize: 18 * scale,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Logout Dialog
  void _showLogoutDialog(BuildContext context, PatientProvider provider, double scale) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20 * scale),
          ),
          title: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16 * scale),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.logout,
                  color: AppColors.error,
                  size: 32 * scale,
                ),
              ),
              SizedBox(height: 16 * scale),
              Text(
                "Logout",
                style: AppTextStyles.headlineSmall.copyWith(
                  fontSize: 20 * scale,
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            "Are you sure you want to logout?",
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 16 * scale,
              color: AppColors.greyDark,
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12 * scale),
                    ),
                    child: Text(
                      "Cancel",
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 16 * scale,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8 * scale),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      provider.logout();
                      Navigator.of(context).pop();
                      Get.offAll(() => const LoginPage());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      padding: EdgeInsets.symmetric(vertical: 12 * scale),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10 * scale),
                      ),
                    ),
                    child: Text(
                      "Logout",
                      style: AppTextStyles.buttonMedium.copyWith(
                        fontSize: 16 * scale,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

// [file name]: lib/screens/home/profile_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../providers/patient_provider.dart';
import '../auth/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    final patientProvider = Provider.of<PatientProvider>(context);
    final patient = patientProvider.currentPatient;

    if (patient == null) {
      return Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_off_outlined,
                size: 80 * scale,
                color: AppColors.grey,
              ),
              SizedBox(height: 16 * scale),
              Text(
                "No user data available",
                style: AppTextStyles.headlineMedium.copyWith(
                  fontSize: 20 * scale,
                  color: AppColors.greyDark,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: CustomScrollView(
        slivers: [
          // ✅ Custom App Bar
          SliverAppBar(
            expandedHeight: 200 * scale,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primaryLight,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40 * scale),
                    // Avatar
                    Container(
                      width: 100 * scale,
                      height: 100 * scale,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                        border: Border.all(
                          color: AppColors.white,
                          width: 4 * scale,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10 * scale,
                            offset: Offset(0, 4 * scale),
                          ),
                        ],
                      ),
                      child: patient.patientImage != null
                          ? ClipOval(
                        child: Image.network(
                          patient.patientImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.person,
                            size: 50 * scale,
                            color: AppColors.primary,
                          ),
                        ),
                      )
                          : Icon(
                        Icons.person,
                        size: 50 * scale,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 12 * scale),
                    Text(
                      patient.patientName ?? "Unknown",
                      style: AppTextStyles.headlineMedium.copyWith(
                        fontSize: 24 * scale,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      patient.patientEmail ?? "",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ✅ Profile Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Personal Info Section
                  _buildSectionTitle("Personal Information", scale),
                  SizedBox(height: 12 * scale),
                  _buildInfoCard(
                    scale,
                    [
                      _buildInfoRow(Icons.cake, "Age", "${patient.patientAge ?? 'N/A'} years", scale),
                      Divider(height: 24 * scale),
                      _buildInfoRow(
                        patient.patientGender == 'male' ? Icons.male : Icons.female,
                        "Gender",
                        patient.patientGender?.capitalize ?? 'N/A',
                        scale,
                      ),
                      Divider(height: 24 * scale),
                      _buildInfoRow(
                        Icons.favorite,
                        "Marital Status",
                        patient.patientMarried == true ? "Married" : "Single",
                        scale,
                      ),
                    ],
                  ),

                  SizedBox(height: 24 * scale),

                  // Contact Info Section
                  _buildSectionTitle("Contact Information", scale),
                  SizedBox(height: 12 * scale),
                  _buildInfoCard(
                    scale,
                    [
                      _buildInfoRow(Icons.phone, "Phone", patient.patientPhone ?? 'N/A', scale),
                      Divider(height: 24 * scale),
                      _buildInfoRow(Icons.location_city, "City", patient.patientCity ?? 'N/A', scale),
                    ],
                  ),

                  SizedBox(height: 24 * scale),

                  // Medical Info Section (if available)
                  if (patient.patientHeight != null || patient.patientWeight != null) ...[
                    _buildSectionTitle("Medical Information", scale),
                    SizedBox(height: 12 * scale),
                    _buildInfoCard(
                      scale,
                      [
                        if (patient.patientHeight != null) ...[
                          _buildInfoRow(Icons.height, "Height", "${patient.patientHeight} cm", scale),
                          if (patient.patientWeight != null) Divider(height: 24 * scale),
                        ],
                        if (patient.patientWeight != null)
                          _buildInfoRow(Icons.monitor_weight, "Weight", "${patient.patientWeight} kg", scale),
                        if (patient.patientBloodType != null) ...[
                          Divider(height: 24 * scale),
                          _buildInfoRow(Icons.bloodtype, "Blood Type", patient.patientBloodType!, scale),
                        ],
                      ],
                    ),
                    SizedBox(height: 24 * scale),
                  ],

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showLogoutDialog(context, patientProvider, scale);
                      },
                      icon: Icon(Icons.logout, size: 20 * scale),
                      label: Text(
                        "Logout",
                        style: AppTextStyles.buttonMedium.copyWith(
                          fontSize: 16 * scale,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: AppColors.white,
                        padding: EdgeInsets.symmetric(vertical: 16 * scale),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14 * scale),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20 * scale),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, double scale) {
    return Text(
      title,
      style: AppTextStyles.headlineSmall.copyWith(
        fontSize: 18 * scale,
        color: AppColors.primaryDark,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoCard(double scale, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10 * scale,
            offset: Offset(0, 4 * scale),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, double scale) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10 * scale),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10 * scale),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 24 * scale,
          ),
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
                  fontSize: 16 * scale,
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context, PatientProvider provider, double scale) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16 * scale),
        ),
        title: Text(
          "Logout",
          style: AppTextStyles.headlineSmall.copyWith(fontSize: 20 * scale),
        ),
        content: Text(
          "Are you sure you want to logout?",
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: AppColors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              provider.logout();
              Navigator.pop(context);
              Get.offAll(() => const LoginPage());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
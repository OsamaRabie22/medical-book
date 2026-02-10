import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';
import 'specialty_doctors_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "Find a Doctor",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
            color: AppColors.primaryDark,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primaryDark,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // بيرجع للصفحة اللي قبلها
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar - نفس تصميم Vezeeta
            Container(
              height: 50 * scale,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12 * scale),
                border: Border.all(
                  color: AppColors.greyLight.withOpacity(0.5),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(width: 16 * scale),
                  Icon(
                    Icons.search,
                    color: AppColors.grey,
                    size: 20 * scale,
                  ),
                  SizedBox(width: 12 * scale),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search by specialty, doctor name, or hospital",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: AppColors.grey,
                          fontSize: 14 * scale,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32 * scale),

            // Most Searched Specialties - بنفس تنسيق Vezeeta
            _buildSectionTitle("Most Searched Specialties"),
            SizedBox(height: 16 * scale),
            _buildSpecialtyRow(
              context,
              [
                _buildSpecialtyItem(
                  context,
                  "Dermatology",
                  LineIcons.heartbeat,
                ),
                _buildSpecialtyItem(
                  context,
                  "Dentist",
                  LineIcons.tooth,
                ),
                _buildSpecialtyItem(
                  context,
                  "Psychiatry",
                  LineIcons.brain,
                ),
              ],
            ),

            SizedBox(height: 32 * scale),

            // Pediatrics & Newborn
            _buildSectionTitle("Pediatrics & Newborn"),
            SizedBox(height: 16 * scale),
            _buildSpecialtyRow(
              context,
              [
                _buildSpecialtyItem(
                  context,
                  "Pediatrics",
                  LineIcons.baby,
                ),
                _buildSpecialtyItem(
                  context,
                  "Newborn Care",
                  Icons.child_friendly,
                ),
                _buildSpecialtyItem(
                  context,
                  "Vaccination",
                  Icons.medical_services,
                ),
              ],
            ),

            SizedBox(height: 32 * scale),

            // Women Health
            _buildSectionTitle("Women Health"),
            SizedBox(height: 16 * scale),
            _buildSpecialtyRow(
              context,
              [
                _buildSpecialtyItem(
                  context,
                  "Obstetrics",
                  LineIcons.female,
                ),
                _buildSpecialtyItem(
                  context,
                  "Gynecology",
                  Icons.female,
                ),
                _buildSpecialtyItem(
                  context,
                  "Fertility",
                  LineIcons.heart,
                ),
              ],
            ),

            SizedBox(height: 32 * scale),

            // Surgery
            _buildSectionTitle("Surgery"),
            SizedBox(height: 16 * scale),
            _buildSpecialtyRow(
              context,
              [
                _buildSpecialtyItem(
                  context,
                  "Orthopedics",
                  Icons.accessible,
                ),
                _buildSpecialtyItem(
                  context,
                  "General Surgery",
                  Icons.medical_services,
                ),
                _buildSpecialtyItem(
                  context,
                  "Plastic Surgery",
                  Icons.face,
                ),
              ],
            ),

            SizedBox(height: 32 * scale),

            // ENT
            _buildSectionTitle("ENT"),
            SizedBox(height: 16 * scale),
            _buildSpecialtyRow(
              context,
              [
                _buildSpecialtyItem(
                  context,
                  "Ear, Nose & Throat",
                  Icons.hearing,
                ),
              ],
            ),

            SizedBox(height: 32 * scale),

            // Internal Medicine
            _buildSectionTitle("Internal Medicine"),
            SizedBox(height: 16 * scale),
            _buildSpecialtyRow(
              context,
              [
                _buildSpecialtyItem(
                  context,
                  "Cardiology",
                  LineIcons.heart,
                ),
                _buildSpecialtyItem(
                  context,
                  "Diabetes",
                  Icons.monitor_heart,
                ),
                _buildSpecialtyItem(
                  context,
                  "Gastroenterology",
                  Icons.health_and_safety,
                ),
              ],
            ),

            SizedBox(height: 32 * scale),

            // Divider - الخط الفاصل
            Divider(
              color: AppColors.greyLight,
              thickness: 1,
              height: 1,
            ),

            SizedBox(height: 24 * scale),

            // Other Specialties
            _buildSectionTitle("Other Specialties"),
            SizedBox(height: 16 * scale),
            Wrap(
              spacing: 12 * scale,
              runSpacing: 12 * scale,
              children: [
                _buildSpecialtyChip(context, "Neurology"),
                _buildSpecialtyChip(context, "Ophthalmology"),
                _buildSpecialtyChip(context, "Urology"),
                _buildSpecialtyChip(context, "Oncology"),
                _buildSpecialtyChip(context, "Rheumatology"),
                _buildSpecialtyChip(context, "Endocrinology"),
                _buildSpecialtyChip(context, "Nephrology"),
                _buildSpecialtyChip(context, "Pulmonology"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    final scale = ResponsiveUtils.getScale(context);

    return Text(
      title,
      style: AppTextStyles.headlineSmall.copyWith(
        fontSize: 18 * scale,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark,
      ),
    );
  }

  Widget _buildSpecialtyRow(BuildContext context, List<Widget> items) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _buildSpecialtyItem(BuildContext context, String title, IconData icon) {
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          _navigateToSpecialtyDoctors(context, title);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4 * scale),
          padding: EdgeInsets.all(16 * scale),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12 * scale),
            border: Border.all(
              color: AppColors.greyLight.withOpacity(0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4 * scale,
                offset: Offset(0, 2 * scale),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 40 * scale,
                height: 40 * scale,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: 20 * scale,
                ),
              ),
              SizedBox(height: 8 * scale),
              Text(
                title,
                style: TextStyle(
                  fontSize: isTablet ? 14 * scale : 12 * scale,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryDark,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialtyChip(BuildContext context, String specialty) {
    final scale = ResponsiveUtils.getScale(context);

    return GestureDetector(
      onTap: () {
        _navigateToSpecialtyDoctors(context, specialty);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16 * scale,
          vertical: 10 * scale,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20 * scale),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.3),
          ),
        ),
        child: Text(
          specialty,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.w500,
            fontSize: 14 * scale,
          ),
        ),
      ),
    );
  }

  void _navigateToSpecialtyDoctors(BuildContext context, String specialty) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SpecialtyDoctorsPage(
          specialty: specialty,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/constants/app_styles.dart';
import '../../states/appointment_state.dart';
import '../../widgets/app_logo.dart';
import 'booking_page.dart';
import 'doctor_card.dart';
import 'header.dart';
import 'search_results_page.dart';
import 'top_doctors_section.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late TextEditingController _searchController;
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _performSearch(BuildContext context) {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      final doctorsProvider = Provider.of<DoctorsProvider>(context, listen: false);
      doctorsProvider.searchDoctors(query);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsPage(initialQuery: query),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctorsProvider = Provider.of<DoctorsProvider>(context);
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 24 * scale : 20 * scale,
          vertical: isTablet ? 12 * scale : 8 * scale,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: AppLogo()),
            buildHeader(context),
            SizedBox(height: isTablet ? 25 * scale : 20 * scale),
            TopDoctorsSection(),
            SizedBox(height: isTablet ? 30 * scale : 25 * scale),
            Container(
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
                  // Search Bar - بدون حدود مع خلفية موحدة
                  Material(
                    color: AppColors.scaffoldBackground,
                    borderRadius: BorderRadius.circular(25 * scale),
                    child: Container(
                      height: 50 * scale,
                      child: Row(
                        children: [
                          SizedBox(width: 16 * scale),
                          Icon(
                            Icons.search,
                            color: AppColors.primary,
                            size: isTablet ? 22 * scale : 20 * scale,
                          ),
                          SizedBox(width: 8 * scale),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              focusNode: _searchFocusNode,
                              decoration: InputDecoration(
                                hintText: "Search doctors, specialties...",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: isTablet ? 15 * scale : 13 * scale,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: isTablet ? 16 * scale : 14 * scale,
                                color: AppColors.primaryDark,
                              ),
                              onSubmitted: (_) => _performSearch(context),
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(right: 12 * scale),
                              child: IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: AppColors.grey,
                                  size: isTablet ? 20 * scale : 18 * scale,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _searchController.clear();
                                    _searchFocusNode.unfocus();
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: isTablet ? 25 * scale : 20 * scale),
                  Text(
                    "All Doctors",
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: AppColors.primaryDark,
                      fontSize: isTablet ? 24 * scale : 22 * scale,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: isTablet ? 20 * scale : 16 * scale),
                  ...doctorsProvider.allDoctors.map((doctor) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: isTablet ? 16 * scale : 14 * scale),
                      child: DoctorCard(
                        doctor: doctor,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingPage(
                                doctorName: doctor.name,
                                specialty: doctor.specialty,
                                doctorImage: doctor.image,
                                rating: doctor.rating,
                                location: doctor.location,
                                consultationFee: doctor.consultationFee,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            SizedBox(height: isTablet ? 30 * scale : 25 * scale),
          ],
        ),
      ),
    );
  }
}
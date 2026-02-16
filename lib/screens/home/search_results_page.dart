import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../states/appointment_state.dart';
import '../home/booking_page.dart';
import '../../widgets/doctor_card.dart';

class SearchResultsPage extends StatefulWidget {
  final String initialQuery;

  const SearchResultsPage({
    super.key,
    this.initialQuery = '',
  });

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  TextEditingController searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    searchController.text = widget.initialQuery;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialQuery.isNotEmpty) {
        final provider = Provider.of<DoctorsProvider>(context, listen: false);
        provider.searchDoctors(widget.initialQuery);
      }
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DoctorsProvider>(context);
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: _buildSearchBar(provider, scale),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primaryDark,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (searchController.text.isNotEmpty)
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                searchController.clear();
                provider.searchDoctors('');
              },
            ),
        ],
      ),
      body: _buildSearchResults(provider, scale, isTablet),
    );
  }

  Widget _buildSearchBar(DoctorsProvider provider, double scale) {
    return Container(
      height: 40 * scale,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10 * scale),
        border: Border.all(
          color: AppColors.greyLight.withOpacity(0.5),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 12 * scale),
          Icon(
            Icons.search,
            color: AppColors.primary,
            size: 20 * scale,
          ),
          SizedBox(width: 8 * scale),
          Expanded(
            child: TextField(
              controller: searchController,
              focusNode: _searchFocusNode,
              decoration: InputDecoration(
                hintText: "Search doctors, specialties, locations...",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: AppColors.grey,
                  fontSize: 14 * scale,
                ),
              ),
              onChanged: (value) {
                provider.searchDoctors(value);
              },
              onSubmitted: (value) {
                provider.searchDoctors(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(
      DoctorsProvider provider, double scale, bool isTablet) {
    final searchResults = provider.filteredDoctors;

    if (searchController.text.isEmpty) {
      return _buildEmptyState(
        Icons.search,
        "Search for doctors",
        "Find your doctor by name, specialty, or location",
        scale,
      );
    }

    if (searchResults.isEmpty) {
      return _buildEmptyState(
        Icons.search_off,
        "No results found",
        "Try different keywords or check spelling",
        scale,
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 16 * scale,
        vertical: 8 * scale,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Results count
          Padding(
            padding: EdgeInsets.only(bottom: 16 * scale),
            child: Text(
              "${searchResults.length} ${searchResults.length == 1 ? 'doctor found' : 'doctors found'}",
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.greyDark,
                fontSize: 14 * scale,
              ),
            ),
          ),
          // Doctors list
          Column(
            children: searchResults.map((doctor) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16 * scale),
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
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(
      IconData icon, String title, String subtitle, double scale) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32 * scale),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64 * scale,
              color: AppColors.greyLight,
            ),
            SizedBox(height: 24 * scale),
            Text(
              title,
              style: AppTextStyles.headlineSmall.copyWith(
                color: AppColors.greyDark,
                fontSize: 20 * scale,
              ),
            ),
            SizedBox(height: 8 * scale),
            Text(
              subtitle,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.grey,
                fontSize: 16 * scale,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

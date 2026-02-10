import 'package:flutter/material.dart';
import '../../core/utils/responsive_utils.dart';
import '../../models/doctor_model.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../home/booking_page.dart';
import '../home/bottom_navigation.dart';
import '../home/doctor_card.dart';
import '../../data/dummy_data.dart'; // تأكد من إضافة هذا الاستيراد

class AppointmentsPageState extends State<AppointmentsPage> {
  int _selectedTab = 0; // 0: Saved, 1: Completed, 2: Cancelled

  // Use a separate list for the saved doctors
  List<Doctor> _savedDoctors = dummyDoctors.where((doctor) => doctor.isSaved).toList();
  List<Booking> _completedAppointments = dummyBookings.where((booking) => booking.status == 'Completed').toList();
  List<Booking> _cancelledAppointments = dummyBookings.where((booking) => booking.status == 'Cancelled').toList();

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "My Appointments",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
            color: AppColors.primaryDark,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primaryDark,
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            margin: EdgeInsets.all(16 * scale),
            height: 50 * scale,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12 * scale),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4 * scale,
                  offset: Offset(0, 2 * scale),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildTabButton("Saved", 0, scale, isTablet),
                _buildTabButton("Completed", 1, scale, isTablet),
                _buildTabButton("Cancelled", 2, scale, isTablet),
              ],
            ),
          ),
          // Content for the selected tab
          Expanded(
            child: _buildCurrentTabContent(scale, isTablet),
          ),
        ],
      ),
    );
  }

  // Tab Button Builder
  Widget _buildTabButton(String text, int index, double scale, bool isTablet) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.white,
            borderRadius: BorderRadius.circular(12 * scale),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: isTablet ? 16 * scale : 14 * scale,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.white : AppColors.greyDark,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build content for the selected tab
  Widget _buildCurrentTabContent(double scale, bool isTablet) {
    switch (_selectedTab) {
      case 0: // Saved
        return _buildSavedTab(scale, isTablet);
      case 1: // Completed
        return _buildAppointmentsTab(_completedAppointments, scale, isTablet);
      case 2: // Cancelled
        return _buildAppointmentsTab(_cancelledAppointments, scale, isTablet);
      default:
        return _buildSavedTab(scale, isTablet);
    }
  }

  // Saved tab content
  Widget _buildSavedTab(double scale, bool isTablet) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Saved Doctors (${_savedDoctors.length})",
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: 20 * scale,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
            ),
          ),
          SizedBox(height: 16 * scale),
          if (_savedDoctors.isNotEmpty)
            ..._savedDoctors.map((doctor) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16 * scale),
                child: DoctorCard(
                  doctor: doctor,
                  onSaveChanged: () {
                    setState(() {
                      doctor.isSaved = !doctor.isSaved;
                      if (doctor.isSaved) {
                        _savedDoctors.add(doctor);
                      } else {
                        _savedDoctors.remove(doctor);
                      }
                    });
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BookingPage(
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
            }).toList()
          else
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 60 * scale,
                    color: AppColors.grey,
                  ),
                  SizedBox(height: 16 * scale),
                  Text(
                    "No saved doctors",
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(height: 8 * scale),
                  Text(
                    "Save your favorite doctors for quick access",
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Completed and Cancelled Appointments Tab Content
  Widget _buildAppointmentsTab(List<Booking> appointments, double scale,
      bool isTablet) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      child: Column(
        children: [
          if (appointments.isNotEmpty)
            ...appointments.map((appointment) {
              return _buildAppointmentCard(appointment, scale, isTablet);
            }).toList()
          else
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _selectedTab == 1
                        ? Icons.check_circle_outline
                        : Icons.cancel_outlined,
                    size: 60 * scale,
                    color: AppColors.grey,
                  ),
                  SizedBox(height: 16 * scale),
                  Text(
                    _selectedTab == 1
                        ? "No completed appointments"
                        : "No cancelled appointments",
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Appointment Card Builder
  Widget _buildAppointmentCard(Booking appointment, double scale,
      bool isTablet) {
    return GestureDetector(
      onTap: () {
        if (_selectedTab == 1) {
          _navigateToBookingPage(appointment);
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16 * scale),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16 * scale),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6 * scale,
              offset: Offset(0, 3 * scale),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16 * scale),
              decoration: BoxDecoration(
                color: appointment.statusBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16 * scale),
                  topRight: Radius.circular(16 * scale),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12 * scale,
                      vertical: 6 * scale,
                    ),
                    decoration: BoxDecoration(
                      color: appointment.statusColor,
                      borderRadius: BorderRadius.circular(20 * scale),
                    ),
                    child: Text(
                      appointment.status,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 12 * scale,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (appointment.isSaved)
                    Icon(
                      Icons.bookmark,
                      color: AppColors.primary,
                      size: 20 * scale,
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12 * scale),
                        child: Image.asset(
                          appointment.doctorImage,
                          width: 70 * scale,
                          height: 70 * scale,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16 * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appointment.doctorName,
                              style: AppTextStyles.headlineSmall.copyWith(
                                fontSize: 16 * scale,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryDark,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4 * scale),
                            Text(
                              appointment.specialty,
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontSize: 14 * scale,
                                color: AppColors.greyDark,
                              ),
                            ),
                            SizedBox(height: 4 * scale),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16 * scale,
                                ),
                                SizedBox(width: 4 * scale),
                                Text(
                                  appointment.rating.toString(),
                                  style: TextStyle(
                                    fontSize: 14 * scale,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16 * scale),
                  _buildDetailRow("Date & Time",
                      "${appointment.date} • ${appointment.time}", scale,
                      isTablet),
                  _buildDetailRow(
                      "Location", appointment.location, scale, isTablet),
                  _buildDetailRow("Fee",
                      "EGP ${appointment.consultationFee.toStringAsFixed(0)}",
                      scale, isTablet),
                  if (_selectedTab == 2) ...[ // Rebook only for cancelled
                    SizedBox(height: 16 * scale),
                    Divider(color: AppColors.greyLight, thickness: 1),
                    SizedBox(height: 12 * scale),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          _navigateToBookingPage(appointment);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12 * scale),
                          side: BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12 * scale),
                          ),
                        ),
                        child: Text(
                          "Rebook Appointment",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Navigate to the Booking Page
  void _navigateToBookingPage(Booking appointment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BookingPage(
              doctorName: appointment.doctorName,
              specialty: appointment.specialty,
              doctorImage: appointment.doctorImage,
              rating: appointment.rating,
              location: appointment.location,
              consultationFee: appointment.consultationFee,
            ),
      ),
    );
  }

  // Helper method to build the detail row
  Widget _buildDetailRow(String label, String value, double scale,
      bool isTablet) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100 * scale,
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 14 * scale,
                color: AppColors.greyDark,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 14 * scale,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:medical_book/screens/home/payment_confirmation_page.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';

class BookingPage extends StatefulWidget {
  final String doctorName;
  final String specialty;
  final String doctorImage;
  final double rating;
  final String location;
  final double consultationFee;

  const BookingPage({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.doctorImage,
    this.rating = 4.9,
    this.location = "Cairo - Maadi",
    this.consultationFee = 250.0,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? selectedDate;
  String? selectedDateText;
  String? selectedPaymentMethod;
  List<String> timeSlots = [
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
    "05:00 PM",
    "05:30 PM",
  ];
  String? selectedTimeSlot;

  List<Map<String, dynamic>> dateOptions = [
    {'day': 'Today', 'date': 'Tue, Dec 5', 'isSelected': false},
    {'day': 'Tomorrow', 'date': 'Wed, Dec 6', 'isSelected': false},
    {'day': 'Thu', 'date': 'Dec 7', 'isSelected': false},
    {'day': 'Fri', 'date': 'Dec 8', 'isSelected': false},
    {'day': 'Sat', 'date': 'Dec 9', 'isSelected': false},
  ];

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "Book Appointment",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 22 * scale,
            color: AppColors.primaryDark,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primaryDark,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: isTablet ? 28 * scale : 24 * scale,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDoctorInfoSection(context, scale, isTablet),
            SizedBox(height: 24 * scale),
            _buildClinicAddressSection(context, scale, isTablet),
            SizedBox(height: 24 * scale),
            _buildDateSelectionSection(context, scale, isTablet),
            SizedBox(height: 24 * scale),
            _buildTimeSelectionSection(context, scale, isTablet),
            SizedBox(height: 24 * scale),
            _buildBookingDetailsSection(context, scale, isTablet),
            SizedBox(height: 32 * scale),
            _buildConfirmButton(context, scale, isTablet),
            SizedBox(height: 16 * scale),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorInfoSection(
      BuildContext context, double scale, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 20 * scale : 16 * scale),
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
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12 * scale),
              child: Container(
                width: isTablet ? 100 * scale : 80 * scale,
                child: Image.asset(
                  widget.doctorImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: isTablet ? 20 * scale : 16 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.doctorName,
                        style: AppTextStyles.headlineSmall.copyWith(
                          fontSize: isTablet ? 20 * scale : 18 * scale,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      SizedBox(height: 6 * scale),
                      Text(
                        widget.specialty,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: isTablet ? 16 * scale : 14 * scale,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8 * scale),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8 * scale,
                              vertical: 4 * scale,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8 * scale),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: isTablet ? 16 * scale : 14 * scale,
                                ),
                                SizedBox(width: 4 * scale),
                                Text(
                                  widget.rating.toString(),
                                  style: TextStyle(
                                    color: AppColors.primaryDark,
                                    fontSize:
                                    isTablet ? 14 * scale : 12 * scale,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12 * scale),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.red.shade400,
                                size: isTablet ? 16 * scale : 14 * scale,
                              ),
                              SizedBox(width: 4 * scale),
                              Text(
                                widget.location,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.grey,
                                  fontSize: isTablet ? 14 * scale : 12 * scale,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12 * scale,
                      vertical: 8 * scale,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.scaffoldBackground,
                      borderRadius: BorderRadius.circular(8 * scale),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.medical_services,
                          color: AppColors.primary,
                          size: isTablet ? 18 * scale : 16 * scale,
                        ),
                        SizedBox(width: 8 * scale),
                        Text(
                          "Consultation Fee:",
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: isTablet ? 16 * scale : 14 * scale,
                            color: AppColors.greyDark,
                          ),
                        ),
                        SizedBox(width: 8 * scale),
                        Text(
                          "EGP ${widget.consultationFee.toStringAsFixed(0)}",
                          style: AppTextStyles.headlineSmall.copyWith(
                            fontSize: isTablet ? 18 * scale : 16 * scale,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClinicAddressSection(
      BuildContext context, double scale, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 20 * scale : 16 * scale),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.primary,
                size: isTablet ? 24 * scale : 20 * scale,
              ),
              SizedBox(width: 12 * scale),
              Text(
                "Clinic Address",
                style: AppTextStyles.headlineSmall.copyWith(
                  fontSize: isTablet ? 18 * scale : 16 * scale,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 12 * scale),
          Padding(
            padding: EdgeInsets.only(left: isTablet ? 36 * scale : 32 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dr. ${widget.doctorName.split(' ').last}'s Clinic",
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontSize: isTablet ? 17 * scale : 15 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8 * scale),
                Text(
                  "${widget.location}\nFloor 3, Clinic 302\nAvailable parking in the building",
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: isTablet ? 16 * scale : 14 * scale,
                    color: AppColors.greyDark,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 12 * scale),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: AppColors.primary,
                      size: isTablet ? 18 * scale : 16 * scale,
                    ),
                    SizedBox(width: 8 * scale),
                    Text(
                      "Clinic Phone: 02 1234 5678",
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: isTablet ? 16 * scale : 14 * scale,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelectionSection(
      BuildContext context, double scale, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 20 * scale : 16 * scale),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: AppColors.primary,
                size: isTablet ? 24 * scale : 20 * scale,
              ),
              SizedBox(width: 12 * scale),
              Text(
                "Select Date",
                style: AppTextStyles.headlineSmall.copyWith(
                  fontSize: isTablet ? 18 * scale : 16 * scale,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 4 * scale),
                ...dateOptions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final dateOption = entry.value;
                  final isSelected = dateOption['isSelected'] as bool;
                  return Row(
                    children: [
                      _buildDateOption(
                        dateOption['day'] as String,
                        dateOption['date'] as String,
                        isSelected,
                        index,
                        scale,
                        isTablet,
                      ),
                      if (index < dateOptions.length - 1)
                        SizedBox(width: 12 * scale),
                    ],
                  );
                }).toList(),
                SizedBox(width: 4 * scale),
              ],
            ),
          ),
          SizedBox(height: 16 * scale),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _selectDate(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.scaffoldBackground,
                foregroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 14 * scale),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12 * scale),
                  side: BorderSide(color: AppColors.primary),
                ),
              ),
              child: Text(
                "Choose Another Date",
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateOption(String day, String date, bool isSelected, int index,
      double scale, bool isTablet) {
    return GestureDetector(
      onTap: () {
        setState(() {
          for (var option in dateOptions) {
            option['isSelected'] = false;
          }
          dateOptions[index]['isSelected'] = true;
          selectedDate = DateTime.now();
          selectedDateText = "$day, $date";
        });
      },
      child: Container(
        constraints: BoxConstraints(
          minWidth: isTablet ? 90 * scale : 80 * scale,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16 * scale,
          vertical: 12 * scale,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.greyLight,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day,
              style: TextStyle(
                fontSize: isTablet ? 16 * scale : 14 * scale,
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColors.white : AppColors.primaryDark,
              ),
            ),
            SizedBox(height: 4 * scale),
            Text(
              date,
              style: TextStyle(
                fontSize: isTablet ? 14 * scale : 12 * scale,
                color: isSelected ? AppColors.white : AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelectionSection(
      BuildContext context, double scale, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 20 * scale : 16 * scale),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: AppColors.primary,
                size: isTablet ? 24 * scale : 20 * scale,
              ),
              SizedBox(width: 12 * scale),
              Text(
                "Select Time Slot",
                style: AppTextStyles.headlineSmall.copyWith(
                  fontSize: isTablet ? 18 * scale : 16 * scale,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 16 * scale),
          Wrap(
            spacing: 12 * scale,
            runSpacing: 12 * scale,
            children: timeSlots.map((time) {
              final isSelected = selectedTimeSlot == time;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTimeSlot = time;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16 * scale,
                    vertical: 12 * scale,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.white,
                    borderRadius: BorderRadius.circular(12 * scale),
                    border: Border.all(
                      color:
                      isSelected ? AppColors.primary : AppColors.greyLight,
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: isTablet ? 16 * scale : 14 * scale,
                      fontWeight: FontWeight.w600,
                      color:
                      isSelected ? AppColors.white : AppColors.primaryDark,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDetailsSection(
      BuildContext context, double scale, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 20 * scale : 16 * scale),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Booking Summary",
            style: AppTextStyles.headlineSmall.copyWith(
              fontSize: isTablet ? 18 * scale : 16 * scale,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
            ),
          ),
          SizedBox(height: 16 * scale),
          _buildDetailRow("Doctor", widget.doctorName, scale, isTablet),
          _buildDetailRow("Specialty", widget.specialty, scale, isTablet),
          _buildDetailRow("Location", widget.location, scale, isTablet),
          if (selectedDateText != null)
            _buildDetailRow("Date", selectedDateText!, scale, isTablet),
          if (selectedTimeSlot != null)
            _buildDetailRow("Time", selectedTimeSlot!, scale, isTablet),
          _buildDetailRow(
              "Consultation Fee",
              "EGP ${widget.consultationFee.toStringAsFixed(0)}",
              scale,
              isTablet),
          SizedBox(height: 16 * scale),
          Divider(
            color: AppColors.greyLight,
            thickness: 1,
          ),
          SizedBox(height: 12 * scale),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount",
                style: AppTextStyles.headlineSmall.copyWith(
                  fontSize: isTablet ? 18 * scale : 16 * scale,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryDark,
                ),
              ),
              Text(
                "EGP ${widget.consultationFee.toStringAsFixed(0)}",
                style: AppTextStyles.headlineMedium.copyWith(
                  fontSize: isTablet ? 22 * scale : 20 * scale,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
      String label, String value, double scale, bool isTablet) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12 * scale),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: isTablet ? 16 * scale : 14 * scale,
              color: AppColors.greyDark,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: isTablet ? 16 * scale : 14 * scale,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(
      BuildContext context, double scale, bool isTablet) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _confirmBooking,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          padding: EdgeInsets.symmetric(vertical: 18 * scale),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16 * scale),
          ),
          elevation: 4,
        ),
        child: Text(
          "Confirm Booking & Proceed to Payment",
          style: AppTextStyles.buttonMedium.copyWith(
            fontSize: isTablet ? 18 * scale : 16 * scale,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 60)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.primary,
            colorScheme: ColorScheme.light(primary: AppColors.primary),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedDateText = "${picked.day}/${picked.month}/${picked.year}";
        for (var option in dateOptions) {
          option['isSelected'] = false;
        }
      });
    }
  }

  void _confirmBooking() {
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select a date"),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    if (selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select a time slot"),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Confirm Booking?",
          style: AppTextStyles.headlineSmall.copyWith(
            color: AppColors.primaryDark,
          ),
        ),
        content: Text(
          "You are about to book an appointment with ${widget.doctorName} "
              "on ${selectedDateText ?? selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} "
              "at ${selectedTimeSlot} for EGP ${widget.consultationFee.toStringAsFixed(0)}",
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.grey,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToPaymentPage(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text(
              "Confirm",
              style: AppTextStyles.buttonMedium,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToPaymentPage(BuildContext context) {


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentConfirmationPage(
          doctorName: widget.doctorName,
          specialty: widget.specialty,
          doctorImage: widget.doctorImage,
          selectedDate: selectedDate ?? DateTime.now(),
          selectedDateText: selectedDateText ??
              "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
          selectedTime: selectedTimeSlot ?? "09:00 AM",
          consultationFee: widget.consultationFee,
        ),
      ),
    );
  }
}
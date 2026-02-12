import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';

class PaymentConfirmationPage extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String doctorImage;
  final DateTime selectedDate;
  final String selectedDateText;
  final String selectedTime;
  final double consultationFee;

  const PaymentConfirmationPage({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.doctorImage,
    required this.selectedDate,
    required this.selectedDateText,
    required this.selectedTime,
    required this.consultationFee,
  });

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment Confirmation",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 20 * scale,
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
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20 * scale),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 100 * scale,
              ),
              SizedBox(height: 25 * scale),
              Text(
                "Booking Confirmed!",
                style: AppTextStyles.headlineLarge.copyWith(
                  fontSize: 28 * scale,
                  color: AppColors.primaryDark,
                ),
              ),
              SizedBox(height: 20 * scale),
              Container(
                padding: EdgeInsets.all(20 * scale),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16 * scale),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8 * scale,
                      offset: Offset(0, 4 * scale),
                    ),
                  ],
                ),
                child: Column(
                  children: [
// صورة الدكتور في CircleAvatar
                    Container(
                      padding: EdgeInsets.all(16 * scale),
                      child: CircleAvatar(
                        radius: 70 * scale,
                        backgroundColor: AppColors.scaffoldBackground,
                        child: ClipOval(
                          child: Image.asset(
                            doctorImage,
                            width: 140 * scale,
                            height: 140 * scale,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

// اسم الدكتور والتخصص
                    Column(
                      children: [
                        Text(
                          "Dr. ${doctorName}", // إضافة Dr. هنا
                          style: AppTextStyles.headlineSmall.copyWith(
                            fontSize: isTablet ? 22 * scale : 20 * scale,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 6 * scale),
                        Text(
                          specialty,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: isTablet ? 18 * scale : 16 * scale,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    SizedBox(height: 20 * scale),

// تفاصيل الحجز بنفس شكل صفحة الحجز
                    _buildConfirmationDetail(
                        "Date", selectedDateText, scale, isTablet),
                    _buildConfirmationDetail(
                        "Time", selectedTime, scale, isTablet),
                    _buildConfirmationDetail(
                        "Consultation Fee",
                        "EGP ${consultationFee.toStringAsFixed(0)}",
                        scale,
                        isTablet),

                    SizedBox(height: 16 * scale),

                    Divider(
                      color: AppColors.greyLight,
                      thickness: 1,
                    ),

                    SizedBox(height: 12 * scale),

// الإجمالي بنفس شكل صفحة الحجز
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Paid",
                          style: AppTextStyles.headlineSmall.copyWith(
                            fontSize: isTablet ? 20 * scale : 18 * scale,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        Text(
                          "EGP ${consultationFee.toStringAsFixed(0)}",
                          style: AppTextStyles.headlineMedium.copyWith(
                            fontSize: isTablet ? 24 * scale : 22 * scale,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32 * scale),
              Text(
                "Your appointment has been successfully booked!\n"
                    "You will receive a confirmation email shortly.",
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 16 * scale,
                  color: AppColors.greyDark,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32 * scale),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(
                    horizontal: 40 * scale,
                    vertical: 18 * scale,
                  ),
                ),
                child: Text(
                  "Back to Home",
                  style: AppTextStyles.buttonMedium.copyWith(
                    fontSize: 18 * scale,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmationDetail(
      String label, String value, double scale, bool isTablet) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12 * scale),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: isTablet ? 17 * scale : 15 * scale,
              color: AppColors.greyDark,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: isTablet ? 17 * scale : 15 * scale,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }
}
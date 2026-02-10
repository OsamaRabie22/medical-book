import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';
import '../../models/doctor_model.dart'; // تأكد من إضافة هذا الـ import

class DoctorCard extends StatefulWidget {
  final Doctor doctor; // تغيير هنا ليكون من نوع Doctor
  final VoidCallback onTap;
  final bool isInitiallySaved;
  final VoidCallback? onSaveChanged;

  const DoctorCard({
    super.key,
    required this.doctor,
    required this.onTap,
    this.isInitiallySaved = false,
    this.onSaveChanged,
  });

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.isInitiallySaved;
  }

  void _toggleSave() {
    setState(() {
      _isSaved = !_isSaved;
    });
    widget.onSaveChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(isTablet ? 20 * scale : 18 * scale),
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackground,
          borderRadius:
          BorderRadius.circular(isTablet ? 24 * scale : 22 * scale),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8 * scale,
              offset: Offset(0, 3 * scale),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الصورة
            ClipRRect(
              borderRadius:
              BorderRadius.circular(isTablet ? 20 * scale : 18 * scale),
              child: Image.asset(
                widget.doctor.image,
                width: isTablet ? 100 * scale : 85 * scale,
                height: isTablet ? 130 * scale : 110 * scale,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: isTablet ? 20 * scale : 18 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.doctor.name,
                          style: AppTextStyles.headlineSmall.copyWith(
                            color: AppColors.primaryDark,
                            fontSize: isTablet ? 19 * scale : 17 * scale,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: _toggleSave,
                        child: Icon(
                          _isSaved ? Icons.bookmark : Icons.bookmark_border,
                          size: isTablet ? 26 * scale : 24 * scale,
                          color: _isSaved ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isTablet ? 6 * scale : 4 * scale),
                  Text(
                    widget.doctor.specialty,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.greyDark,
                      fontSize: isTablet ? 16 * scale : 14 * scale,
                    ),
                  ),
                  SizedBox(height: isTablet ? 8 * scale : 6 * scale),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: isTablet ? 18 * scale : 16 * scale,
                        color: Colors.red.shade400,
                      ),
                      SizedBox(width: isTablet ? 6 * scale : 4 * scale),
                      Expanded(
                        child: Text(
                          widget.doctor.location,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.greyDark,
                            fontSize: isTablet ? 14 * scale : 12 * scale,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isTablet ? 8 * scale : 6 * scale),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: isTablet ? 20 * scale : 18 * scale,
                        color: Colors.amber.shade700,
                      ),
                      SizedBox(width: isTablet ? 6 * scale : 4 * scale),
                      Text(
                        widget.doctor.rating.toString(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
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
      ),
    );
  }
}

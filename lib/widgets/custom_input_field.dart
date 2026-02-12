import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final double scale;
  final bool hasError;
  final TextInputType keyboardType;
  final Function(String)? onChanged; // ✅ إضافة onChanged

  const CustomInputField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.scale = 1.0,
    this.hasError = false,
    this.keyboardType = TextInputType.text,
    this.onChanged, // ✅ إضافة onChanged
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.hasError
            ? AppColors.error.withOpacity(0.05)
            : AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18 * widget.scale),
        border: Border.all(
          color: widget.hasError
              ? AppColors.error
              : AppColors.primary.withOpacity(0.3),
          width: 1 * widget.scale,
        ),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged, // ✅ إضافة onChanged هنا
        style: TextStyle(
          fontSize: 16 * widget.scale,
          color: widget.hasError ? AppColors.error : AppColors.primaryDark,
        ),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
            fontSize: 14 * widget.scale,
            color: widget.hasError ? AppColors.error : AppColors.grey,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(
            widget.icon,
            size: 20 * widget.scale,
            color: widget.hasError ? AppColors.error : AppColors.primary,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              size: 20 * widget.scale,
              color: widget.hasError ? AppColors.error : AppColors.grey,
            ),
            onPressed: () => setState(() => _obscureText = !_obscureText),
          )
              : null,
          contentPadding: EdgeInsets.all(16 * widget.scale),
        ),
      ),
    );
  }
}